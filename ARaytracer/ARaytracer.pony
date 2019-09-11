use "files"
use "debug"

actor Main
    new create(env: Env) =>
        env.out.print("Hello ARaytracer")
        try
            let filepath = FilePath.create(env.root as AmbientAuth, "./img_out.ppm")?
            filepath.remove()
            match CreateFile(filepath)
            | let f: File => 
                env.out.print("Position in file: " + f.position().string())
                let width_x: U32 = 200
                let height_y: U32 = 100

                f.print("P3")
                f.print(width_x.string() + " " + height_y.string())
                f.print("255")
                let lower_left: Vec3 = (-2.0, -1.0, -1.0) 
                let horizontal: Vec3 = (4.0, 0.0, 0.0)
                let vertical: Vec3 = (0.0, 2.0, 0.0)
                let origin: Vec3 = (0.0, 0.0, 0.0)
                var y: U32 = height_y

                while y > 0 do
                    var x: U32 = 0
                    while x < width_x do 
                        let u: F32 = x.f32() / width_x.f32()
                        let v: F32 = y.f32() / (height_y-1).f32()
                        let ray: Ray = (origin, Linalg.add(lower_left, Linalg.add(Linalg.smul(u, horizontal), Linalg.smul(v, vertical))))
                        var c: Vec3 = (1.0, 1.0, 1.0)
                        let center: Vec3 = (0,0,-1)
                        let t: F32 = Its.ray_sphere(ray, (center, 0.5))
                        if t > 0 then
                            let n: Vec3 = Linalg.normalized(Linalg.sub(RayLib.at(ray, t), center))
                            c = n
                        end
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

    fun color(ray: Ray): RGB255 =>
        let c: Vec3 = (0.3, 0.3, 0.3)
        Color.vec3toRGB255(c)
