class Ray
    let a: Vec3 val
    let b: Vec3 val
    new create(a': Vec3 val, b': Vec3 val) =>
        a = a'
        b = b'
    
    fun at(t: F32): Vec3 val => a + (b.mul_scalar(t))