robot (name,attack,hp) = (\message -> message (name,attack,hp))

killerRobot = robot ("Kill3r", 25, 200)
gentleGiant = robot ("Mr. Friendly", 10, 300)
fastRobot = robot ("Allan", 15, 40)
slowRobot = robot ("Grimm", 20, 30)

name (n, _, _) = n

attack (_, a, _) = a

hps (_, _, h) = h

getName bot = bot name
--setName bot newName = robot (newName, (getAttack bot), (getHp bot))
setName bot newName = bot (\(n, a, h) -> robot (newName, a, h))

getAttack bot = bot attack
setAttack bot newAttack = bot (\(n, a, h) -> robot (n, newAttack, h))

getHp bot = bot hps 
setHps bot newHps = bot (\(n, a, h) -> robot (n, a, newHps))

printRobot bot = 
    bot (\(n, a, h) ->  n ++
                    " has an attack of " ++ show(a) ++
                    " and has " ++ show(h) ++ " hit points")

damage bot dmgAmt = bot (\(n, a, h) -> robot (n, a, h-dmgAmt))

fight bot defender = 
    damage defender dmgAmt
    where dmgAmt =  if getHp bot > 10
                    then getAttack bot
                    else 0

{-
 - Sample fight:
 - gentleRound01 = fight killerRobot gentleGiant
 - killerRound01 = fight gentleGiant killerRobot
 - gentleRound02 = fight killerRound01 gentleRound01
 - killerRound02 = fight gentleRound01 killerRound01
 - gentleRound03 = fight killerRound02 gentleRound02
 - killerRound03 = fight gentleRound02 killerRound02
 - printRobot gentleGiant
 - printRobot killerRObot 
-}

{- 
 - Sample fight where robots attack sequentially
 - slowRound01 = fight fastRobot slowRobot
 - fastRound01 = fight slowRound01 fastRobot
 - slowRound02 = fight fastRound01 slowRound01
 - fastRound02 = fight slowRound02 fastRound01
 - slowRound03 = fight fastRound02 slowRound02
 - fastRound03 = fight slowRound03 fastRound02
 - printRobot fastRobot
 - printRobot slowRobot 
-}

{-
 - Here's something interesting, because haskell is stateless
 - it does not matter what order we call these in!
 - The outcome is the same.
 -}

gentleRound03 = fight killerRound02 gentleRound02 
killerRound02 = fight gentleRound01 killerRound01
killerRound03 = fight gentleRound02 killerRound02
gentleRound01 = fight killerRobot gentleGiant
killerRound01 = fight gentleGiant killerRobot
gentleRound02 = fight killerRound01 gentleRound01


