use "debug"

type RGB255 is (U8, U8, U8)

primitive Color
    fun vec3toRGB255(v: Vec3) : RGB255 =>
        // u_vec: Vec3 = Linalg.normalized(v)
        (let a, let b, let c) = Linalg.smul(255.99, v)
        (a.floor().u8(), b.floor().u8(), c.floor().u8())

    fun rGB255toString(c: RGB255): String =>
        c._1.string() + " " + c._2.string() + " " + c._3.string() 