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
    
    