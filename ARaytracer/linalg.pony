/*
class Vec3 val
    let x: Array[F32] val 
    new create(a': F32, b': F32, c': F32) =>
        x = recover [a'; b'; c'] end
    fun val a() : F32 => try x(0)? else 0 end
    fun val b() : F32 => try x(1)? else 0 end
    fun val c() : F32 => try x(2)? else 0 end
    fun add(o: Vec3 val): Vec3 =>  Vec3(a() + o.a(), b() + o.b(), c() + o.c())
    fun sub(o: Vec3 val): Vec3 =>  Vec3(a() - o.a(), b() - o.b(), c() - o.c())
    fun mul(o: Vec3 val): Vec3 =>  Vec3(a() * o.a(), b() * o.b(), c() * o.c())
    fun val mul_scalar(o: F32): Vec3 => recover Vec3(a() * o, b() * o, c() * o) end

    fun div(o: Vec3 val): Vec3 =>  Vec3(a() / o.a(), b() / o.b(), c() / o.c())
    fun neg(): Vec3 => Vec3(-a(), -b(), -c())
    fun dot(o: Vec3 val ): F32 => (a()*o.a()) + (b()*o.b()) + (c()*o.c())
    fun val squared_length(): F32 => this.dot(this)
    fun val length(): F32 => this.squared_length().sqrt()
    fun val normalized() : Vec3 => 
        let k = this.length()
        Vec3(a() / k, b() / k, c() / k)

*/  
type Vec3 is (F32, F32, F32)
type CoordSystem is (Vec3, Vec3, Vec3)

primitive Linalg
    fun val add(a: Vec3 val, b: Vec3 val): Vec3 =>
        (let x1, let y1, let z1) = a
        (let x2, let y2, let z2) = b
        (x1 + x2, y1 + y2, z1 + z2)
    
    fun val smul(t: F32, a: Vec3 val): Vec3 =>
        (let x, let y, let z) = a
        (t*x, t*y, t*z)

    fun val sdiv(a: Vec3 val, k: F32): Vec3 =>
        (let x, let y, let z) = a
        (x/k, y/k, z/k)
    
    fun sub(a: Vec3, b: Vec3): Vec3 =>
        (let x1, let y1, let z1) = a
        (let x2, let y2, let z2) = b
        (x1 - x2, y1 - y2, z1 - z2)

    fun mul(a: Vec3, b: Vec3): Vec3 =>
        (let x1, let y1, let z1) = a
        (let x2, let y2, let z2) = b
        (x1 * x2, y1 * y2, z1 * z2)
    
    fun div(a: Vec3, b: Vec3): Vec3 =>
        (let x1, let y1, let z1) = a
        (let x2, let y2, let z2) = b
        (x1 / x2, y1 / y2, z1 / z2)

    fun dot(a: Vec3, b: Vec3): F32 =>
        (let x1, let y1, let z1) = a
        (let x2, let y2, let z2) = b
        (x1 *x2)  + (y1 * y2) + (z1 * z2)

    fun cross(a: Vec3, b:Vec3): Vec3 => 
        (let x1, let y1, let z1) = a
        (let x2, let y2, let z2) = b
        ((y1*z2) - (z1*y2), (z1*x2) - (x1*z2), (x1*y2) - (y1*x2))

    fun neg(a: Vec3): Vec3 => (-a._1, -a._2, -a._3)

    
    fun squared_norm(a: Vec3): F32 => dot(a, a)
    fun norm(a: Vec3): F32 => squared_norm(a).sqrt()
    fun normalized(a: Vec3): Vec3 => sdiv(a, norm(a)) 

    fun create_coord_system(a: Vec3):CoordSystem => 
        let b: Vec3 = normalized(if a._1.abs() > a._2.abs() 
            then (-a._3, 0, a._1) else (0, a._3, -a._1) end)
        let c: Vec3 = cross(a, b)
        (a, b, c)


    