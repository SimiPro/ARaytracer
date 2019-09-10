use "files"

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

                let lower_left: Vec3 = (-2.0, -1.0, -1.0) 
                let horizontal: Vec3 = (4.0, 0.0, 0.0)
                let vertical: Vec3 = (0.0, 2.0, 0.0)
                let origin: Vec3 = (0.0, 0.0, 0.0)
                var x: U32 = 0
                var y: U32 = 0

                while x < width_x do
                    while y < height_y do 
                        let u = x.f32_unsafe() / width_x.f32_unsafe()
                        let v = y.f32_unsafe() / height_y.f32_unsafe()
                        let ray: Ray = (origin, Linalg.add(lower_left, Linalg.add(Linalg.smul(u, horizontal), Linalg.smul(v, vertical))))
                        
                        y = y + 1
                    end 
                    x = x + 1
                end

                f.print("255")
                f.print("255   0   0     0 255   0     0   0 255")
                f.print("255 255   0   255 255 255     0   0   0")
                f.dispose()
            | let err: FileErrNo => env.out.print("Error creating file")
            end
//            file.write("bashbdl")
//            env.out.print("Position in file: " + file.position().string())
        else
            env.out.print("Could not open img_out.ppm")
        end

    fun color(ray: Ray): Vec3 =>
        (0.3, 0.3, 0.3)