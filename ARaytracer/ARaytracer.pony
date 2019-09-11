use "files"
use "debug"
use "random"


actor Main
    let world: World = World.create()
    let rand:Rand = Rand

    new create(env: Env) =>
        env.out.print("Hello ARaytracer")
        try
            let filepath = FilePath.create(env.root as AmbientAuth, "./img_out.ppm")?
            filepath.remove()
            match CreateFile(filepath)
            | let f: File => 
                env.out.print("Position in file: " + f.position().string())
                let width_x: U32 = 400
                let height_y: U32 = 200

                f.print("P3")
                f.print(width_x.string() + " " + height_y.string())
                f.print("255")

                var y: U32 = height_y

                let center: Vec3 = (0,0,-1)
                let s1 = Sphere.create(center, 0.5)
                let s2 = Sphere.create((0, -100.5, -1), 100) 

                world.addObj(s1)
                world.addObj(s2)

                let camera = Camera.create()
                


                while y > 0 do
                    var x: U32 = 0
                    while x < width_x do 
                        var z: U16 = 0
                        var c: Vec3 = (1.0, 1.0, 1.0)
                        let n_samples: U16 = 32
                        while z < n_samples do
                            let u: F32 = (x.f32() + rand.real().f32()) / width_x.f32() 
                            let v: F32 = (y.f32() + rand.real().f32()) / (height_y-1).f32()
                            let ray = camera.sampleRay(u, v)       
                            var c': Vec3 = trace_ray(ray)
                            c = Linalg.add(c, c')
                            z = z + 1
                        end
                        c = Linalg.sdiv(c, n_samples.f32())
                        
                        
                        let col = Color.vec3toRGB255(c)
                        f.print(Color.rGB255toString(col))
                        x = x + 1
                    end 
                    y = y - 1
                end

            
               // f.print("255   0   0     0 255   0     0   0 255")
               // f.print("255 255   0   255 255 255     0   0   0")
                f.dispose()
            | let err: FileErrNo => env.out.print("Error creating file")
            end
//            file.write("bashbdl")
//            env.out.print("Position in file: " + file.position().string())
        else
            env.out.print("Could not open img_out.ppm")
        end

    fun ref rfloat(): F32 => rand.real().f32()

    fun ref rp_in_sphere(): Vec3 => 
        var p: Vec3 = (0,0,0)
        repeat
            p = ((2.0*rfloat()) -1, (2.0*rfloat())-1, (2.0*rfloat())-1)
        until Linalg.squared_norm(p) < 1 end
        p


    fun ref trace_ray(ray: Ray): Vec3 =>
        var c': Vec3 = (1.0, 1.0, 1.0)
        match world.its(ray)
        | let k: Hit => 
            let target: Vec3 = Linalg.add(Linalg.add(k._2, k._3), rp_in_sphere())
            return Linalg.smul(0.5, trace_ray( (k._2, Linalg.sub(target, k._2), 0.001, 100)))
        end
        c'

    fun color(ray: Ray): RGB255 =>
        let c: Vec3 = (0.3, 0.3, 0.3)
        Color.vec3toRGB255(c)
