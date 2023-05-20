globals[
  sum-links-green
  sum-links-red
]

turtles-own
[
  misinformed?
  well-informed?
  phone-use
  link-of
]

to setup
  clear-all
  setup-nodes
  setup-links
  ask links [set color white]
  ask turtles[
  if count link-neighbors < 1[  ;no solitary turtles
      die
    ]
  ]
  calculate-sum-links
  reset-ticks
end

to go
  spread-misinformed
  spread-wellinformed
  calculate-sum-links
  if count turtles with [color = red] < 1[stop]   ;if the number of either the red or the green turtles is 0
  if count turtles with [color = green] < 1[stop] ;the model should terminate because there are no further changes possible
  tick
end

to setup-nodes
  set-default-shape turtles "circle"
  create-turtles number-of-nodes
  [
    set size 0.5
    set color grey
    set well-informed? false       ;initial turtles are undecided
    set misinformed? false
    setxy random-pxcor random-pycor
    set phone-use random-float 6.99 ;based on studies we found that the avarage phone use is around 3.5 hours per day
    set link-of 0                   ;no links have been initialized yet
  ]

  ask turtles [                    ;so the turtles don't overlap
    find-empty-patch
  ]

  ;based on research papers, we estimated the percentige of misinformed people in the population to be 5
  let red-num number-of-nodes * 0.05
  ask n-of red-num turtles with [xcor < 0 and ycor < 0][
    set color red
    set misinformed? true
    while [phone-use < 2.1][                 ;sets the initial phone use of misinformed people higher (2.1-7 hours)
      set phone-use random-float 6.9         ;30 - 100%
    ]
    set phone-use (phone-use * (1 + (misinformation-bias? / 100)))
    ]
  ;based on research papers, we estimated the percentige of well informed people in the population to be 11
  let green-num number-of-nodes * 0.11
  ask n-of green-num turtles with [xcor > 0 and ycor > 0][
    set color green
    set well-informed? true
    while [phone-use > 5][                 ;sets the initial phone use of well informed people lower (0-5 hours)
      set phone-use random-float 6.9       ;0 - 70%
    ]
  ]

end

to setup-links
  let r 4
  if number-of-nodes < 200                           ;for visualisation purposes
  [set r 5.5]
  repeat connections-per-node * count turtles / 2 [  ;calculate number of links to initialise
    ask one-of turtles [
      let choice one-of other turtles in-radius r with [ not link-neighbor? myself ]
      if choice != nobody [create-link-with choice]  ;create links
      set link-of link-of + 1                        ;add one to the link counter of the specific turtle
    ]
  ]
end

to find-empty-patch                               ;Wilensky, U., Rand, W. (2006)
 rt random-float 360                              ;turtle procedure for finding a patch with no other turtles on it
 fd random-float 10
  if any? other turtles-here [ find-empty-patch ] ;recursive call to the same procedure
 move-to patch-here
end

to calculate-sum-links
  set sum-links-green 0
  ask links[
    if [color] of end1 =  green or [color] of end2 = green [   ;calculate the number of links at a certain time step for
    set sum-links-green sum-links-green + 1                    ;green nodes specifically
  ]
  ]
  set sum-links-red 0
  ask links[
    if [color] of end1 =  red or [color] of end2 = red [       ;calculate the number of links at a certain time step for
    set sum-links-red sum-links-red + 1                        ;red nodes specifically
  ]
  ]
end

to become-wellinformed                            ;Stonedahl, F. and Wilensky, U. (2008)
  if misinformed?[                                ;check wether the node is misinformed
  set misinformed? false                          ;if it is, then neutralise the bias term
  set well-informed? true
  set color green
  set phone-use phone-use * (1 / (1 + (misinformation-bias? / 100)))
  ]
  if not misinformed? and not well-informed?[     ;if the node is undecided
    set misinformed? false                        ;there should be no changes made in its phone use
    set well-informed? true
    set color green
  ]
end

to become-misinformed                          ;Stonedahl, F. and Wilensky, U. (2008)
  if well-informed?[                           ;check wether the node is well informed
  set misinformed? true                        ;if it is, then multiply the phone use by the bias term
  set well-informed? false
  set color red
  ifelse (phone-use * (1 + (misinformation-bias? / 100))) > 6.9  ;so the probability does not go over 99._%
    [set phone-use 6.9]
    [set phone-use (phone-use * (1 + (misinformation-bias? / 100)))]
  ]
  if not well-informed? and not misinformed?[   ;if the node is undecided,
    set misinformed? true                       ;then the bias term should be added to its phone use
    set well-informed? false
    set color red
    ifelse (phone-use * (1 + (misinformation-bias? / 100))) > 6.9
    [set phone-use 6.9]
    [set phone-use (phone-use * (1 + (misinformation-bias? / 100)))]
  ]
end

to spread-wellinformed                                 ;Stonedahl, F. and Wilensky, U. (2008)
  ask turtles with [well-informed?]
    [ ask link-neighbors                               ;lower phone use will result in believing information easier
        [if random-float 100 > ((phone-use / 7) * 100) ;and vice versa
            [ become-wellinformed ] ] ]
end

to spread-misinformed                                  ;Stonedahl, F. and Wilensky, U. (2008)
  ask turtles with [misinformed?]
    [ ask link-neighbors                               ;higher phone use will result in believing information easier
        [if random-float 100 < ((phone-use / 7) * 100) ;and vice versa
            [ become-misinformed ] ] ]
end
