type Sphere is (Vec3, F32)

primitive Its
    fun ray_sphere(s: Sphere, r: Ray): Bool => 
        (let center, let radius) = s
        (let orig, let dir) = r
        let oc = Linalg.sub(orig, center)
        let a = Linalg.squared_norm(dir)
        let b = 2*Linalg.dot(dir, oc)
        let c = Linalg.squared_norm(oc) - (radius*radius)
        let discr = (b*b) - (4*a*c)
        discr > 0
