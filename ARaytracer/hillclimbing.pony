use "debug"

trait Candidate 
    fun val clone(): Candidate val
    fun val tweak() : Candidate val
trait CandidateFactory
    fun val initialize() : Candidate val
    
class ArrayCandidate is Candidate
    let x: Array[F32] iso
    new iso create(x' : Array[F32] iso) =>
        x = consume x'

    fun val clone() : Candidate val =>
        let iso_array: Array[F32] iso = recover Array[F32].create(10) end
        var new_candidate: ArrayCandidate iso =  ArrayCandidate.create(consume iso_array)
        var counter: USize = 0
        while counter < x.size() do
            try // we should never have an error here since we loop over size which is equal for both arrays
                new_candidate.x.update(counter, x(counter)?)?
            end
        end
        consume new_candidate

    fun val tweak() : Candidate val =>
        let iso_array: Array[F32] iso = recover Array[F32].create(x.size()) end
        ArrayCandidate.create(consume iso_array)


class ArrayCandidateFactory is CandidateFactory
    fun val initialize() : Candidate val =>
        let iso_array: Array[F32] iso = recover Array[F32].create(10) end
        ArrayCandidate.create(consume iso_array)

actor NeighborHillclimbing
    let cf: CandidateFactory val
    var solution: Candidate val

    new create(cf' : CandidateFactory val) =>
        cf = cf'
        solution = cf.initialize()

    be climb() =>
        var counter : U32 = 1
        while counter <= 10 do
            var r: Candidate val = solution.tweak()
            if quality_C(solution) < quality_C(r) then
                solution = r
            end
        end
    
    fun quality_C(x: Candidate val): F32 => 
        1
    
    fun tweak(x: Array[F32] box) : Array[F32] ref =>
        var s = Array[F32].create(10)
        s

    fun initialize() : Array[F32] ref =>
        Array[F32].create(10)
    
    fun quality(x: Array[F32] val): F32 => 
        1


        