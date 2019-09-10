type Ray is (Vec3, Vec3)

primitive RayLib
    fun at(ray: Ray, t: F32): Vec3 => 
        (let o, let d) = ray
        Linalg.add(o, Linalg.smul(t, d))
