function love.load()
  -- Initialize game state
  game = {
    tileSize = 32,
    worldWidth = 50,
    worldHeight = 20,
    world = {},
    player = {
      x = 100,
      y = 100,
      width = 32,
      height = 64,
      speed = 200,
      jumpForce = -500,
      yVelocity = 0,
      isJumping = false
    },
    gravity = 1500
  }

  -- Generate a simple world with platforms
  for x = 1, game.worldWidth do
    game.world[x] = {}
    for y = 1, game.worldHeight do
      if y == game.worldHeight or
         (x > 5 and x < 10 and y == 15) or
         (x > 15 and x < 20 and y == 12) or
         (x > 25 and x < 30 and y == 9) then
        game.world[x][y] = 1  -- 1 represents platform
      else
        game.world[x][y] = 0  -- 0 represents air
      end
    end
  end
end

function love.update(dt)
  local player = game.player

  -- Handle player movement
  if love.keyboard.isDown('left') then
    player.x = player.x - player.speed * dt
  elseif love.keyboard.isDown('right') then
    player.x = player.x + player.speed * dt
  end

  -- Apply gravity
  player.yVelocity = player.yVelocity + game.gravity * dt
  player.y = player.y + player.yVelocity * dt

  -- Check for collisions with platforms
  local leftTile = math.floor(player.x / game.tileSize) + 1
  local rightTile = math.floor((player.x + player.width) / game.tileSize) + 1
  local topTile = math.floor(player.y / game.tileSize) + 1
  local bottomTile = math.floor((player.y + player.height) / game.tileSize) + 1

  player.isJumping = true

  for y = topTile, bottomTile do
    for x = leftTile, rightTile do
      if game.world[x] and game.world[x][y] == 1 then
        if player.yVelocity > 0 and player.y + player.height > (y-1) * game.tileSize and player.y < (y-1) * game.tileSize then
          player.y = (y-1) * game.tileSize - player.height
          player.yVelocity = 0
          player.isJumping = false
        end
      end
    end
  end

  -- Keep player within world bounds
  player.x = math.max(0, math.min(player.x, game.worldWidth * game.tileSize - player.width))
  player.y = math.max(0, math.min(player.y, game.worldHeight * game.tileSize - player.height))
end

function love.keypressed(key)
  if key == 'space' and not game.player.isJumping then
    game.player.yVelocity = game.player.jumpForce
    game.player.isJumping = true
  end
end

function love.draw()
  -- Draw the world
  for x = 1, game.worldWidth do
    for y = 1, game.worldHeight do
      if game.world[x][y] == 1 then
        love.graphics.setColor(0.5, 0.5, 0.5)  -- Gray for platforms
        love.graphics.rectangle('fill', (x-1) * game.tileSize, (y-1) * game.tileSize, game.tileSize, game.tileSize)
      end
    end
  end

  -- Draw the player
  love.graphics.setColor(1, 0, 0)  -- Red for player
  love.graphics.rectangle('fill', game.player.x, game.player.y, game.player.width, game.player.height)
end
