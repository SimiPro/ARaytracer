type Ray is (Vec3, Vec3, F32, F32)

primitive RayLib
    fun at(ray: Ray, t: F32): Vec3 => 
        Linalg.add(ray._1, Linalg.smul(t, ray._2))


class Camera
    let lower_left: Vec3 = (-2.0, -1.0, -1.0) 
    let horizontal: Vec3 = (4.0, 0.0, 0.0)
    let vertical: Vec3 = (0.0, 2.0, 0.0)
    let origin: Vec3 = (0.0, 0.0, 0.0)
    new val create() => 
        """
        """

    fun val sampleRay(u: F32, v: F32) : Ray => 
        (origin, 
        Linalg.add(lower_left, Linalg.add(Linalg.smul(u, horizontal), Linalg.smul(v, vertical))),
        0.0001, 100.0)



