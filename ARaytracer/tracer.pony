type Ray is (Vec3, Vec3, F32, F32)

primitive RayLib
    fun at(ray: Ray, t: F32): Vec3 => 
        Linalg.add(ray._1, Linalg.smul(t, ray._2))

