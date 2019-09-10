use "debug"
use "ponytest"
use ".."

class iso _TestHillclimber is UnitTest
    fun name(): String => "Test Hillclimber"

    fun apply(h: TestHelper) =>
        let cf:ArrayCandidateFactory iso = ArrayCandidateFactory.create()
        let hillclimbing = NeighborHillclimbing.create(consume cf)