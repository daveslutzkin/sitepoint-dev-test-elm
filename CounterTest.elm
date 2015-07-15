import Array
import String

import ElmTest.Test exposing (suite, test)
import ElmTest.Assertion exposing (assert, assertEqual)
import ElmTest.Runner.Element exposing (runDisplay)

import Counter exposing (..)


tests = suite "CounterTests"
        [ addCounterTests
        , removeCounterTests
        , modifyCounterTests
        ]

addCounterTests = suite "AddCounterTests"
                  [ testAddCounterToEmpty
                  , testAddCounterToNonEmpty
                  ]

testAddCounterToEmpty = test "AddCounterToEmpty" (
    assertEqual (update AddCounter (Array.fromList [])) (Array.fromList [0])
  )
testAddCounterToNonEmpty = test "AddCounterToNonEmpty" (
    assertEqual (update AddCounter (Array.fromList [1])) (Array.fromList [1,0])
  )

removeCounterTests = suite "RemoveCounterTests"
                     [ testRemoveCounterWhenFirst
                     , testRemoveCounterWhenLast
                     , testRemoveCounterWhenInMiddle
                     , testRemoveCounterWhenOutOfBounds
                     ]

testRemoveCounterWhenFirst = test "RemoveCounterWhenFirst" (
    assertEqual (update (RemoveCounter 0) (Array.fromList [1,2,3])) (Array.fromList [2,3])
  )
testRemoveCounterWhenLast = test "RemoveCounterWhenLast" (
    assertEqual (update (RemoveCounter 2) (Array.fromList [1,2,3])) (Array.fromList [1,2])
  )
testRemoveCounterWhenInMiddle = test "RemoveCounterWhenInMiddle" (
    assertEqual (update (RemoveCounter 1) (Array.fromList [1,2,3])) (Array.fromList [1,3])
  )
testRemoveCounterWhenOutOfBounds = test "RemoveCounterWhenOutOfBounds" (
    assertEqual (update (RemoveCounter 3) (Array.fromList [1,2,3])) (Array.fromList [1,2,3])
  )

modifyCounterTests = suite "ModifyCounterTests"
                     [ testModifyCounterBasic
                     , testModifyCounterNegativeDelta
                     , testModifyCounterOutOfBounds
                     ]

testModifyCounterBasic = test "ModifyCounterBasic" (
    assertEqual (update (ModifyCounter 1 3) (Array.fromList [1,2,3])) (Array.fromList [1,5,3])
  )
testModifyCounterNegativeDelta = test "ModifyCounterNegativeDelta" (
    assertEqual (update (ModifyCounter 1 -2) (Array.fromList [1,2,3])) (Array.fromList [1,0,3])
  )
testModifyCounterOutOfBounds = test "ModifyCounterOutOfBounds" (
    assertEqual (update (ModifyCounter 3 3) (Array.fromList [1,2,3])) (Array.fromList [1,2,3])
  )

main = runDisplay tests
