use "random"

class Sampler
    let rand:Rand

    new create() =>
        rand = Rand

    new create_with_rand(rand': Rand) => 
        rand = rand'

    fun ref rfloat(): F32 => rand.real().f32()

    fun ref rp_in_sphere(): Vec3 => 
        var p: Vec3 = (0,0,0)
        repeat
            p = ((2.0*rfloat()) -1, (2.0*rfloat())-1, (2.0*rfloat())-1)
        until Linalg.squared_norm(p) < 1 end
        p