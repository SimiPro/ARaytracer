type Sphere is (Vec3, F32)
// t, hit point, normal
type Hit is (F32, Vec3, Vec3)
class Hit val
    let t: F32
    let p: Vec3
    let n: Vec3

    new create(t': F32, p': Vec3, n': Vec3) =>
        t = t'
        p = p'
        n = n'

trait IsHitable
    fun

primitive Its
    fun ray_sphere(r: Ray, s: Sphere): F32 => 
        (let center, let radius) = s
        (let orig, let dir) = r
        let oc = Linalg.sub(orig, center)
        let a = Linalg.squared_norm(dir)
        let b = 2*Linalg.dot(dir, oc)
        let c = Linalg.squared_norm(oc) - (radius*radius)
        let discr = (b*b) - (4*a*c)
        if discr < 0 then -1.0 else (-b - discr.sqrt()) / (2.0*a) end
