
// t, hit point, normal
class val Hit
    let t: F32
    let p: Vec3 // hitpoint 
    let n: Vec3
    let in_dir: Vec3 // in direction always points away! from hitpoint

    new val create(t': F32, p': Vec3, normal': Vec3, in_dir': Vec3) =>
        t = t'
        p = p'
        n = normal'
        in_dir = in_dir'


trait Hitable
    fun its(ray: Ray): (Hit | None)

trait Material
    fun scatter(ray: Ray, hit: Hit, sampler: Sampler ref)

type Object is (Material & Hitable)

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
                return Hit.create(tmp, p, Linalg.sdiv(Linalg.sub(p, center), radius), Linalg.neg(ray._2))
            end
            tmp = (-b + discr.sqrt())/a
            if (tmp < tmax) and (tmp > tmin) then
                let p = RayLib.at(ray, tmp)
                return Hit.create(tmp, p, Linalg.sdiv(Linalg.sub(p, center), radius), Linalg.neg(ray._2))
            end
        end

class Lambert is Material
    let albedo: F32
    
    new val create(albedo': F32) =>
        albedo = albedo'

    fun scatter(ray: Ray, hit: Hit, sampler: Sampler ref) => 
        let target: Vec3 = Linalg.add(Linalg.add(hit.p, hit.n), sampler.rp_in_sphere())
        //new_ray: Ray =  Linalg.smul(0.5, trace_ray((hit.p, Linalg.sub(target, hit.p), 0.001, 100)))
        let new_ray: Ray = (hit.p, Linalg.sub(target, hit.p), 0.001, 100)
        None

/*
class Metal is Material

    fun reflect(a: Vec3, n: Vec3) => Linalg.sub(v, Linalg.smul(2*Linalg.dot(a, n), n))

    fun scatter(ray: Ray, hit: Hit, sampler: Sampler ref) => 
        new_ray: Vec3 = reflect(Linalg.normalized(hit._3, ))

*/

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
                hit_ray = (hit_ray._1, hit_ray._2, hit_ray._3, h1.t)
            end
        end
        hit

