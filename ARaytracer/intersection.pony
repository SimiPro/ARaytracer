
// t, hit point, normal
type Hit is (F32, Vec3, Vec3)

trait Hitable
    fun its(ray: Ray): (Hit | None)

class Sphere is Hitable
    let center: Vec3
    let radius: F32
    new val create(center': Vec3, radius': F32) =>
        center = center'
        radius = radius'

    fun its(ray: Ray): (Hit | None) =>
        (let orig, let dir, let tmin, let tmax) = ray
        let oc = Linalg.sub(orig, center)
        let a = Linalg.squared_norm(dir)
        let b = Linalg.dot(dir, oc)
        let c = Linalg.squared_norm(oc) - (radius*radius)
        let discr = (b*b) - (a*c)
        if discr > 0 then
            var tmp = (-b - discr.sqrt())/a
            if  (tmp < tmax) and (tmp > tmin) then
                let p = RayLib.at(ray, tmp)
                return (tmp, p, Linalg.sdiv(Linalg.sub(p, center), radius))
            end
            tmp = (-b + discr.sqrt())/a
            if (tmp < tmax) and (tmp > tmin) then
                let p = RayLib.at(ray, tmp)
                return (tmp, p, Linalg.sdiv(Linalg.sub(p, center), radius))
            end
        end

class World is Hitable
    let objs: Array[Hitable val]
    new create() => 
        objs = Array[Hitable val].create()

    fun ref addObj(obj: Hitable val) =>
        objs.push(obj)

    fun its(ray: Ray): (Hit | None) =>
        var hit: (Hit | None) = None
        var hit_ray = ray
        for obj in objs.values() do
            match obj.its(hit_ray)
            | let h1 : Hit => 
                hit = h1
                // set tmax of ray to current min hit
                hit_ray = (hit_ray._1, hit_ray._2, hit_ray._3, h1._1)
            end
        end
        hit

