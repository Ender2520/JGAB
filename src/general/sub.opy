#!mainFile "../main.opy"

def Round_Status():
    @Name "Subroutine Round_Status"
    
    if not chaosMode:
        roundStatus = "Warm Up"
        waitUntil(not getMatchTime() >= roundLength - 15, 9999)
        roundStatus = "Normal Phase"
        waitUntil(not getMatchTime() >= roundLength * 0.5, 9999)
        roundStatus = "Final Phase"
    else:
        roundStatus = "{0} CHAOS PHASE {0}".format(iconString(Icon.SKULL))

def GamePhase_SpawnBots():
    @Name "Subroutine GamePhase_SpawnBots"
    
    roundUnderway = true
    async(Round_Status, AsyncBehavior.NOOP)
    setObjectiveDescription(getAllPlayers(), "Survive Until The Timer Ends!", HudReeval.VISIBILITY)
    setMatchTime(120 if chaosMode else roundLength)
    wait()
    unpauseMatchTime()
    ### Actual Game Mechanics
    #
    # SPAWN DELAYS
    enemyMAXSpawnDelays = [Hero.PHARAH,1.5,3,Hero.ORISA,2,4,Hero.MEI,2.5,5,Hero.REINHARDT,3,6]
    enemyMINSpawnDelays = [Hero.PHARAH,0.75,1.5,Hero.ORISA,1,2,Hero.MEI,1.25,2.5,Hero.REINHARDT,1.5,3]
    #
    # Determine Difficulty
    # 
    if testMode == true:
        enemySpawnWeights = [0,0,0,1]
        while getNumberOfPlayers(Team.1) != 0 or getMatchTime() > 0.1:
            #GLOBAL WAIT
            wait(9999/*0.15*/)
            rng = random.randint(1, 100)
            #Spawn Pharah
            if rng <= 100 * (enemySpawnWeights[0] / totalWeights):
                createDummy(Hero.PHARAH, Team.2, -1, vect(0, 50, 0), vect(0, 0, 0))
                wait(random.uniform(0, 1) * fPhase)
                #Spawn Orisa
            elif rng <= 100 * ((enemySpawnWeights[0] + enemySpawnWeights[1]) / totalWeights):
                createDummy(Hero.ORISA, Team.2, -1, vect(0, 50, 0), vect(0, 0, 0))
                wait(random.uniform(0.5, 1.5) * fPhase)
                #Spawn Mei
            elif rng <= 100 * ((enemySpawnWeights[0] + enemySpawnWeights[1] + enemySpawnWeights[2]) / totalWeights):
                createDummy(Hero.MEI, Team.2, -1, vect(0, 50, 0), vect(0, 0, 0))
                wait(random.uniform(1, 2) * fPhase)
                #Spawn Reinhardt
            elif rng <= 100 * (totalWeights / totalWeights):
                createDummy(Hero.REINHARDT, Team.2, -1, vect(0, 50, 0), vect(0, 0, 0))
                wait(random.uniform(1.5, 2.5) * fPhase)
    elif chaosMode == true:
        enemySpawnWeights = [100,90,50,48]
        while getNumberOfPlayers(Team.1) != 0 or getMatchTime() > 0.1:
            #GLOBAL WAIT
            wait(0.15)
            rng = random.randint(1, 100)
            #Spawn Pharah
            if rng <= 100 * (enemySpawnWeights[0] / totalWeights):
                createDummy(Hero.PHARAH, Team.2, -1, vect(0, 50, 0), vect(0, 0, 0))
                wait(random.uniform(0, 1) * fPhase)
                #Spawn Orisa
            elif rng <= 100 * ((enemySpawnWeights[0] + enemySpawnWeights[1]) / totalWeights):
                createDummy(Hero.ORISA, Team.2, -1, vect(0, 50, 0), vect(0, 0, 0))
                wait(random.uniform(0.5, 1.5) * fPhase)
                #Spawn Mei
            elif rng <= 100 * ((enemySpawnWeights[0] + enemySpawnWeights[1] + enemySpawnWeights[2]) / totalWeights):
                createDummy(Hero.MEI, Team.2, -1, vect(0, 50, 0), vect(0, 0, 0))
                wait(random.uniform(1, 2) * fPhase)
                #Spawn Reinhardt
            elif rng <= 100 * (totalWeights / totalWeights):
                createDummy(Hero.REINHARDT, Team.2, -1, vect(0, 50, 0), vect(0, 0, 0))
                wait(random.uniform(1.5, 2.5) * fPhase)
    else:
        if difficulty == 1:
            enemySpawnWeights = [100,0,0,0]
        elif difficulty == 2:
            enemySpawnWeights = [100,10,0,0]
        elif difficulty == 3:
            enemySpawnWeights = [100,20,10,0]
        elif difficulty == 4:
            enemySpawnWeights = [100,30,10,0]
        elif difficulty == 5:
            enemySpawnWeights = [100,40,20,8]
        elif difficulty == 6:
            enemySpawnWeights = [100,50,20,16]
        elif difficulty == 7:
            enemySpawnWeights = [100,60,30,24]
        elif difficulty == 8:
            enemySpawnWeights = [100,70,30,32]
        elif difficulty == 9:
            enemySpawnWeights = [100,80,40,40]
        else:
            enemySpawnWeights = [100,90,50,48]
        while getNumberOfPlayers(Team.1) != 0 or getMatchTime() > 0.1:
            #GLOBAL WAIT
            wait(0.15)
            rng = random.randint(1, 100)
            #Determine Bot Type
            # Spawn Pharah
            if rng <= 100 * (enemySpawnWeights[0] / totalWeights):
                createDummy(Hero.PHARAH, Team.2, -1, vect(0, 50, 0), vect(0, 0, 0))
                wait(spawnDelay(Hero.PHARAH) * fPhase)
                #Spawn Orisa
            elif rng <= 100 * ((enemySpawnWeights[0] + enemySpawnWeights[1]) / totalWeights):
                createDummy(Hero.ORISA, Team.2, -1, vect(0, 50, 0), vect(0, 0, 0))
                wait(spawnDelay(Hero.ORISA) * fPhase)
                #Spawn Mei
            elif rng <= 100 * ((enemySpawnWeights[0] + enemySpawnWeights[1] + enemySpawnWeights[2]) / totalWeights):
                createDummy(Hero.MEI, Team.2, -1, vect(0, 50, 0), vect(0, 0, 0))
                wait(spawnDelay(Hero.MEI) * fPhase)
                #Spawn Reinhardt
            elif rng <= 100 * (totalWeights / totalWeights):
                createDummy(Hero.REINHARDT, Team.2, -1, vect(0, 50, 0), vect(0, 0, 0))
                wait(spawnDelay(Hero.REINHARDT) * fPhase)