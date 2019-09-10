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
                f.print("P3")
                f.print("3 2")
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