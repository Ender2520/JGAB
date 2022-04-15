#!mainFile "../main.opy"

def Round_Status():
    if not chaosMode:
        roundStatus = "Warm Up"
        waitUntil(not wuPhase, 9999)
        roundStatus = "Normal Phase"
        waitUntil(not nPhase, 9999)
        roundStatus = "Final Phase"
    else:
        roundStatus = "{0} CHAOS PHASE {0}".format(iconString(Icon.SKULL))

def GamePhase_SpawnBots():
    async(Round_Status(), AsyncBehavior.NOOP)
    setObjectiveDescription(getAllPlayers(), "Survive Until The Timer Ends!", HudReeval.VISIBILITY)
    setMatchTime(chaos(120) 60 + (difficulty*6))
    wait()
    unpauseMatchTime()
    roundUnderway = true
    ### Actual Game Mechanics
    #
    # Determine Difficulty
    if chaosMode == true:
        pWeight = 100
        oWeight = 90
        mWeight = 50
        rWeight = 48
        while len(getPlayers(Team.1)) != 0 or getMatchTime() > 0.1:
            #GLOBAL WAIT
            wait(0.15)
            rng = random.randint(1,100)
            if rng <= 100*((pWeight)/totalWeight): # Spawn Pharah
                createDummy(Hero.PHARAH, Team.2, -1, vect(0,50,0), vect(0,0,0))
                getLastCreatedEntity().enemyType = random.randint(0,2)
                wait(random.randint(0, 1) + (len(getPlayers(Team.2)) * 0.02))
            elif rng <= 100*((pWeight+oWeight)/totalWeight): # Spawn Orisa
                createDummy(Hero.ORISA, Team.2, -1, vect(0,50,0), vect(0,0,0))
                getLastCreatedEntity().enemyType = random.randint(0,1)
                wait(random.randint(0.5, 1.5) + (len(getPlayers(Team.2)) * 0.02))
            elif rng <= 100*((pWeight+oWeight+mWeight)/totalWeight): # Spawn Mei
                createDummy(Hero.MEI, Team.2, -1, vect(0,50,0), vect(0,0,0))
                getLastCreatedEntity().enemyType = random.randint(0,1)
                wait(random.randint(1, 2) + (len(getPlayers(Team.2)) * 0.02))
            elif rng <= 100*((pWeight+oWeight+mWeight+rWeight)/totalWeight): # Spawn Reinhardt
                createDummy(Hero.REINHARDT, Team.2, -1, vect(0,50,0), vect(0,0,0))
                getLastCreatedEntity().enemyType = random.randint(0,1)
                wait(random.randint(1.5, 2.5) + (len(getPlayers(Team.2)) * 0.02))
    elif difficulty == 1 or difficulty == 2:
        if difficulty == 1:
            pWeight = 100
            oWeight = 0
            mWeight = 0
            rWeight = 0
        else:
            pWeight = 100
            oWeight = 10
            mWeight = 0
            rWeight = 0
        while len(getPlayers(Team.1)) != 0 or getMatchTime() > 0.1:
            #GLOBAL WAIT
            wait(0.15)
            rng = random.randint(1,100)
            if nPhase:
                # Determine Bot Type
                if rng <= 100*((pWeight)/totalWeight): # Spawn Pharah
                    createDummy(Hero.PHARAH, Team.2, -1, vect(0,50,0), vect(0,0,0))
                    getLastCreatedEntity().enemyType = random.randint(0,2)
                    wait(random.randint(1, 4) + (len(getPlayers(Team.2)) * 0.02))
                elif rng <= 100*((pWeight+oWeight)/totalWeight): # Spawn Orisa
                    createDummy(Hero.ORISA, Team.2, -1, vect(0,50,0), vect(0,0,0))
                    getLastCreatedEntity().enemyType = random.randint(0,1)
                    wait(random.randint(2, 5) + (len(getPlayers(Team.2)) * 0.02))
                elif rng <= 100*((pWeight+oWeight+mWeight)/totalWeight): # Spawn Mei
                    createDummy(Hero.MEI, Team.2, -1, vect(0,50,0), vect(0,0,0))
                    getLastCreatedEntity().enemyType = random.randint(0,1)
                    wait(random.randint(3, 6) + (len(getPlayers(Team.2)) * 0.02))
                elif rng <= 100*((pWeight+oWeight+mWeight+rWeight)/totalWeight): # Spawn Reinhardt
                    createDummy(Hero.REINHARDT, Team.2, -1, vect(0,50,0), vect(0,0,0))
                    getLastCreatedEntity().enemyType = random.randint(0,1)
                    wait(random.randint(4, 6) + (len(getPlayers(Team.2)) * 0.02))
            else:
                # Determine Bot Type
                if rng <= 100*((pWeight)/totalWeight): # Spawn Pharah
                    createDummy(Hero.PHARAH, Team.2, -1, vect(0,50,0), vect(0,0,0))
                    getLastCreatedEntity().enemyType = random.randint(0,2)
                    wait(random.randint(1 * 0.75, 4 * 0.75) + (len(getPlayers(Team.2)) * 0.125))
                elif rng <= 100*((pWeight+oWeight)/totalWeight): # Spawn Orisa
                    createDummy(Hero.ORISA, Team.2, -1, vect(0,50,0), vect(0,0,0))
                    getLastCreatedEntity().enemyType = random.randint(0,1)
                    wait(random.randint(2 * 0.75, 5 * 0.75) + (len(getPlayers(Team.2)) * 0.125))
                elif rng <= 100*((pWeight+oWeight+mWeight)/totalWeight): # Spawn Mei
                    createDummy(Hero.MEI, Team.2, -1, vect(0,50,0), vect(0,0,0))
                    getLastCreatedEntity().enemyType = random.randint(0,1)
                    wait(random.randint(3 * 0.75, 6 * 0.75) + (len(getPlayers(Team.2)) * 0.125))
                elif rng <= 100*((pWeight+oWeight+mWeight+rWeight)/totalWeight): # Spawn Reinhardt
                    createDummy(Hero.REINHARDT, Team.2, -1, vect(0,50,0), vect(0,0,0))
                    getLastCreatedEntity().enemyType = random.randint(0,1)
                    wait(random.randint(4 * 0.75, 6 * 0.75) + (len(getPlayers(Team.2)) * 0.02))
    elif difficulty == 3 or difficulty == 4:
        if difficulty == 3:
            pWeight = 100
            oWeight = 20
            mWeight = 10
            rWeight = 0
        else:
            pWeight = 100
            oWeight = 30
            mWeight = 10
            rWeight = 0
        while len(getPlayers(Team.1)) != 0 or getMatchTime() > 0.1:
            #GLOBAL WAIT
            wait(0.15)
            rng = random.randint(1,100)
            if nPhase:
                # Determine Bot Type
                if rng <= 100*((pWeight)/totalWeight): # Spawn Pharah
                    createDummy(Hero.PHARAH, Team.2, -1, vect(0,50,0), vect(0,0,0))
                    getLastCreatedEntity().enemyType = random.randint(0,2)
                    wait(random.randint(0.8, 3.6) + (len(getPlayers(Team.2)) * 0.1))
                elif rng <= 100*((pWeight+oWeight)/totalWeight): # Spawn Orisa
                    createDummy(Hero.ORISA, Team.2, -1, vect(0,50,0), vect(0,0,0))
                    getLastCreatedEntity().enemyType = random.randint(0,1)
                    wait(random.randint(1.7, 4.5) + (len(getPlayers(Team.2)) * 0.1))
                elif rng <= 100*((pWeight+oWeight+mWeight)/totalWeight): # Spawn Mei
                    createDummy(Hero.MEI, Team.2, -1, vect(0,50,0), vect(0,0,0))
                    getLastCreatedEntity().enemyType = random.randint(0,1)
                    wait(random.randint(2.6, 5.4) + (len(getPlayers(Team.2)) * 0.1))
                elif rng <= 100*((pWeight+oWeight+mWeight+rWeight)/totalWeight): # Spawn Reinhardt
                    createDummy(Hero.REINHARDT, Team.2, -1, vect(0,50,0), vect(0,0,0))
                    getLastCreatedEntity().enemyType = random.randint(0,1)
                    wait(random.randint(3.5, 5.5) + (len(getPlayers(Team.2)) * 0.02))
            else:
                # Determine Bot Type
                if rng <= 100*((pWeight)/totalWeight): # Spawn Pharah
                    createDummy(Hero.PHARAH, Team.2, -1, vect(0,50,0), vect(0,0,0))
                    getLastCreatedEntity().enemyType = random.randint(0,2)
                    wait(random.randint(0.8 * 0.75, 3.6 * 0.75) + (len(getPlayers(Team.2)) * 0.1))
                elif rng <= 100*((pWeight+oWeight)/totalWeight): # Spawn Orisa
                    createDummy(Hero.ORISA, Team.2, -1, vect(0,50,0), vect(0,0,0))
                    getLastCreatedEntity().enemyType = random.randint(0,1)
                    wait(random.randint(1.7 * 0.75, 4.5 * 0.75) + (len(getPlayers(Team.2)) * 0.1))
                elif rng <= 100*((pWeight+oWeight+mWeight)/totalWeight): # Spawn Mei
                    createDummy(Hero.MEI, Team.2, -1, vect(0,50,0), vect(0,0,0))
                    getLastCreatedEntity().enemyType = random.randint(0,1)
                    wait(random.randint(2.6 * 0.75, 5.4 * 0.75) + (len(getPlayers(Team.2)) * 0.1))
                elif rng <= 100*((pWeight+oWeight+mWeight+rWeight)/totalWeight): # Spawn Reinhardt
                    createDummy(Hero.REINHARDT, Team.2, -1, vect(0,50,0), vect(0,0,0))
                    getLastCreatedEntity().enemyType = random.randint(0,1)
                    wait(random.randint(3.5 * 0.75, 5.5 * 0.75) + (len(getPlayers(Team.2)) * 0.02))
    elif difficulty == 5 or difficulty == 6:
        if difficulty == 5:
            pWeight = 100
            oWeight = 40
            mWeight = 20
            rWeight = 8
        else:
            pWeight = 100
            oWeight = 50
            mWeight = 20
            rWeight = 16
        while len(getPlayers(Team.1)) != 0 or getMatchTime() > 0.1:
            #GLOBAL WAIT
            wait(0.15)
            rng = random.randint(1,100)
            if nPhase:
                # Determine Bot Type
                if rng <= 100*((pWeight)/totalWeight): # Spawn Pharah
                    createDummy(Hero.PHARAH, Team.2, -1, vect(0,50,0), vect(0,0,0))
                    getLastCreatedEntity().enemyType = random.randint(0,2)
                    wait(random.randint(0.6, 3.2) + (len(getPlayers(Team.2)) * 0.08))
                elif rng <= 100*((pWeight+oWeight)/totalWeight): # Spawn Orisa
                    createDummy(Hero.ORISA, Team.2, -1, vect(0,50,0), vect(0,0,0))
                    getLastCreatedEntity().enemyType = random.randint(0,1)
                    wait(random.randint(1.4, 4) + (len(getPlayers(Team.2)) * 0.08))
                elif rng <= 100*((pWeight+oWeight+mWeight)/totalWeight): # Spawn Mei
                    createDummy(Hero.MEI, Team.2, -1, vect(0,50,0), vect(0,0,0))
                    getLastCreatedEntity().enemyType = random.randint(0,1)
                    wait(random.randint(2.2, 4.8) + (len(getPlayers(Team.2)) * 0.08))
                elif rng <= 100*((pWeight+oWeight+mWeight+rWeight)/totalWeight): # Spawn Reinhardt
                    createDummy(Hero.REINHARDT, Team.2, -1, vect(0,50,0), vect(0,0,0))
                    getLastCreatedEntity().enemyType = random.randint(0,1)
                    wait(random.randint(3, 5) + (len(getPlayers(Team.2)) * 0.02))
            else:
                # Determine Bot Type
                if rng <= 100*((pWeight)/totalWeight): # Spawn Pharah
                    createDummy(Hero.PHARAH, Team.2, -1, vect(0,50,0), vect(0,0,0))
                    getLastCreatedEntity().enemyType = random.randint(0,2)
                    wait(random.randint(0.6 * 0.75, 3.2 * 0.75) + (len(getPlayers(Team.2)) * 0.08))
                elif rng <= 100*((pWeight+oWeight)/totalWeight): # Spawn Orisa
                    createDummy(Hero.ORISA, Team.2, -1, vect(0,50,0), vect(0,0,0))
                    getLastCreatedEntity().enemyType = random.randint(0,1)
                    wait(random.randint(1.4 * 0.75, 4 * 0.75) + (len(getPlayers(Team.2)) * 0.08))  
                elif rng <= 100*((pWeight+oWeight+mWeight)/totalWeight): # Spawn Mei
                    createDummy(Hero.MEI, Team.2, -1, vect(0,50,0), vect(0,0,0))
                    getLastCreatedEntity().enemyType = random.randint(0,1)
                    wait(random.randint(2.2 * 0.75, 4.8 * 0.75) + (len(getPlayers(Team.2)) * 0.08))
                elif rng <= 100*((pWeight+oWeight+mWeight+rWeight)/totalWeight): # Spawn Reinhardt
                    createDummy(Hero.REINHARDT, Team.2, -1, vect(0,50,0), vect(0,0,0))
                    getLastCreatedEntity().enemyType = random.randint(0,1)
                    wait(random.randint(3 * 0.75, 5 * 0.75) + (len(getPlayers(Team.2)) * 0.02))
    elif difficulty == 7 or difficulty == 8:
        if difficulty == 7:
            pWeight = 100
            oWeight = 60
            mWeight = 30
            rWeight = 24
        else:
            pWeight = 100
            oWeight = 70
            mWeight = 30
            rWeight = 32
        while len(getPlayers(Team.1)) != 0 or getMatchTime() > 0.1:
            #GLOBAL WAIT
            wait(0.15)
            rng = random.randint(1,100)
            if nPhase:
                # Determine Bot Type
                if rng <= 100*((pWeight)/totalWeight): # Spawn Pharah
                    createDummy(Hero.PHARAH, Team.2, -1, vect(0,50,0), vect(0,0,0))
                    getLastCreatedEntity().enemyType = random.randint(0,2)
                    wait(random.randint(0.4, 2.8) + (len(getPlayers(Team.2)) * 0.06))
                elif rng <= 100*((pWeight+oWeight)/totalWeight): # Spawn Orisa
                    createDummy(Hero.ORISA, Team.2, -1, vect(0,50,0), vect(0,0,0))
                    getLastCreatedEntity().enemyType = random.randint(0,1)
                    wait(random.randint(1.1, 3.5) + (len(getPlayers(Team.2)) * 0.06))
                elif rng <= 100*((pWeight+oWeight+mWeight)/totalWeight): # Spawn Mei
                    createDummy(Hero.MEI, Team.2, -1, vect(0,50,0), vect(0,0,0))
                    getLastCreatedEntity().enemyType = random.randint(0,1)
                    wait(random.randint(1.8, 4.2) + (len(getPlayers(Team.2)) * 0.06))
                elif rng <= 100*((pWeight+oWeight+mWeight+rWeight)/totalWeight): # Spawn Reinhardt
                    createDummy(Hero.REINHARDT, Team.2, -1, vect(0,50,0), vect(0,0,0))
                    getLastCreatedEntity().enemyType = random.randint(0,1)
                    wait(random.randint(2.5, 4.5) + (len(getPlayers(Team.2)) * 0.02))
            else:
                # Determine Bot Type
                if rng <= 100*((pWeight)/totalWeight): # Spawn Pharah
                    createDummy(Hero.PHARAH, Team.2, -1, vect(0,50,0), vect(0,0,0))
                    getLastCreatedEntity().enemyType = random.randint(0,2)
                    wait(random.randint(0.4 * 0.75, 2.8 * 0.75) + (len(getPlayers(Team.2)) * 0.06))
                elif rng <= 100*((pWeight+oWeight)/totalWeight): # Spawn Orisa
                    createDummy(Hero.ORISA, Team.2, -1, vect(0,50,0), vect(0,0,0))
                    getLastCreatedEntity().enemyType = random.randint(0,1)
                    wait(random.randint(1.1 * 0.75, 3.5 * 0.75) + (len(getPlayers(Team.2)) * 0.06))
                elif rng <= 100*((pWeight+oWeight+mWeight)/totalWeight): # Spawn Mei
                    createDummy(Hero.MEI, Team.2, -1, vect(0,50,0), vect(0,0,0))
                    getLastCreatedEntity().enemyType = random.randint(0,1)
                    wait(random.randint(1.8 * 0.75, 4.2 * 0.75) + (len(getPlayers(Team.2)) * 0.06))
                elif rng <= 100*((pWeight+oWeight+mWeight+rWeight)/totalWeight): # Spawn Reinhardt
                    createDummy(Hero.REINHARDT, Team.2, -1, vect(0,50,0), vect(0,0,0))
                    getLastCreatedEntity().enemyType = random.randint(0,1)
                    wait(random.randint(2.5 * 0.75, 4.5 * 0.75) + (len(getPlayers(Team.2)) * 0.02))
    elif difficulty == 9:
        pWeight = 100
        oWeight = 80
        mWeight = 40
        rWeight = 40
        while len(getPlayers(Team.1)) != 0 or getMatchTime() > 0.1:
            #GLOBAL WAIT
            wait(0.15)
            rng = random.randint(1,100)
            if nPhase:
                # Determine Bot Type
                if rng <= 50: # Spawn Pharah
                    createDummy(Hero.PHARAH, Team.2, -1, vect(0,50,0), vect(0,0,0))
                    getLastCreatedEntity().enemyType = random.randint(0,2)
                    wait(random.randint(0.2, 2.4) + (len(getPlayers(Team.2)) * 0.04))
                elif rng <= 100*((pWeight+oWeight)/totalWeight): # Spawn Orisa
                    createDummy(Hero.ORISA, Team.2, -1, vect(0,50,0), vect(0,0,0))
                    getLastCreatedEntity().enemyType = random.randint(0,1)
                    wait(random.randint(0.8, 3) + (len(getPlayers(Team.2)) * 0.04))
                elif rng <= 100*((pWeight+oWeight+mWeight)/totalWeight): # Spawn Mei
                    createDummy(Hero.MEI, Team.2, -1, vect(0,50,0), vect(0,0,0))
                    getLastCreatedEntity().enemyType = random.randint(0,1)
                    wait(random.randint(1.4, 3.6) + (len(getPlayers(Team.2)) * 0.04))
                elif rng <= 100*((pWeight+oWeight+mWeight+rWeight)/totalWeight): # Spawn Reinhardt
                    createDummy(Hero.REINHARDT, Team.2, -1, vect(0,50,0), vect(0,0,0))
                    getLastCreatedEntity().enemyType = random.randint(0,1)
                    wait(random.randint(2, 4) + (len(getPlayers(Team.2)) * 0.02))
            else:
                # Determine Bot Type
                if rng <= 100*((pWeight)/totalWeight): # Spawn Pharah
                    createDummy(Hero.PHARAH, Team.2, -1, vect(0,50,0), vect(0,0,0))
                    getLastCreatedEntity().enemyType = random.randint(0,2)
                    wait(random.randint(0.2 * 0.75, 2.4 * 0.75) + (len(getPlayers(Team.2)) * 0.04))
                elif rng <= 100*((pWeight+oWeight)/totalWeight): # Spawn Orisa
                    createDummy(Hero.ORISA, Team.2, -1, vect(0,50,0), vect(0,0,0))
                    getLastCreatedEntity().enemyType = random.randint(0,1)
                    wait(random.randint(0.8 * 0.75, 3 * 0.75) + (len(getPlayers(Team.2)) * 0.04))
                elif rng <= 100*((pWeight+oWeight+mWeight)/totalWeight): # Spawn Mei
                    createDummy(Hero.MEI, Team.2, -1, vect(0,50,0), vect(0,0,0))
                    getLastCreatedEntity().enemyType = random.randint(0,1)
                    wait(random.randint(1.4 * 0.75, 3.6 * 0.75) + (len(getPlayers(Team.2)) * 0.04))
                elif rng <= 100*((pWeight+oWeight+mWeight+rWeight)/totalWeight): # Spawn Reinhardt
                    createDummy(Hero.REINHARDT, Team.2, -1, vect(0,50,0), vect(0,0,0))
                    getLastCreatedEntity().enemyType = random.randint(0,1)
                    wait(random.randint(2 * 0.75, 4 * 0.75) + (len(getPlayers(Team.2)) * 0.02))
    elif difficulty == 10:
        pWeight = 100
        oWeight = 90
        mWeight = 50
        rWeight = 48
        while len(getPlayers(Team.1)) != 0 or getMatchTime() > 0.1:
            #GLOBAL WAIT
            wait(0.15)
            rng = random.randint(1,100)
            if nPhase:
                # Determine Bot Type
                if rng <= 100*((pWeight)/totalWeight): # Spawn Pharah
                    createDummy(Hero.PHARAH, Team.2, -1, vect(0,50,0), vect(0,0,0))
                    getLastCreatedEntity().enemyType = random.randint(0,2)
                    wait(random.randint(0, 2) + (len(getPlayers(Team.2)) * 0.02))
                elif rng <= 100*((pWeight+oWeight)/totalWeight): # Spawn Orisa
                    createDummy(Hero.ORISA, Team.2, -1, vect(0,50,0), vect(0,0,0))
                    getLastCreatedEntity().enemyType = random.randint(0,1)
                    wait(random.randint(0.5, 2.5) + (len(getPlayers(Team.2)) * 0.02))
                elif rng <= 100*((pWeight+oWeight+mWeight)/totalWeight): # Spawn Mei
                    createDummy(Hero.MEI, Team.2, -1, vect(0,50,0), vect(0,0,0))
                    getLastCreatedEntity().enemyType = random.randint(0,1)
                    wait(random.randint(1, 3) + (len(getPlayers(Team.2)) * 0.02))
                elif rng <= 100: # Spawn Reinhardt
                    createDummy(Hero.REINHARDT, Team.2, -1, vect(0,50,0), vect(0,0,0))
                    getLastCreatedEntity().enemyType = random.randint(0,1)
                    wait(random.randint(1.5, 3.5) + (len(getPlayers(Team.2)) * 0.02))
            else:
                # Determine Bot Type
                if rng <= 100*((pWeight)/totalWeight): # Spawn Pharah
                    createDummy(Hero.PHARAH, Team.2, -1, vect(0,50,0), vect(0,0,0))
                    getLastCreatedEntity().enemyType = random.randint(0,2)
                    wait(random.randint(0 * 0.75, 2 * 0.75) + (len(getPlayers(Team.2)) * 0.02))
                elif rng <= 100*((pWeight+oWeight)/totalWeight): # Spawn Orisa
                    createDummy(Hero.ORISA, Team.2, -1, vect(0,50,0), vect(0,0,0))
                    getLastCreatedEntity().enemyType = random.randint(0,1)
                    wait(random.randint(0.5 * 0.75, 2.5 * 0.75) + (len(getPlayers(Team.2)) * 0.02))
                elif rng <= 100*((pWeight+oWeight+mWeight)/totalWeight): # Spawn Mei
                    createDummy(Hero.MEI, Team.2, -1, vect(0,50,0), vect(0,0,0))
                    getLastCreatedEntity().enemyType = random.randint(0,1)
                    wait(random.randint(1 * 0.75, 3 * 0.75) + (len(getPlayers(Team.2)) * 0.02))
                elif rng <= 100*((pWeight+oWeight+mWeight+rWeight)/totalWeight): # Spawn Reinhardt
                    createDummy(Hero.REINHARDT, Team.2, -1, vect(0,50,0), vect(0,0,0))
                    getLastCreatedEntity().enemyType = random.randint(0,1)
                    wait(random.randint(1.5 * 0.75, 3.5 * 0.75) + (len(getPlayers(Team.2)) * 0.02))