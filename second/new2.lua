function love.load()
   mb_img = love.graphics.newImage("metaball.png")
   canv = love.graphics.newCanvas(800,600)
   effect = love.graphics.newPixelEffect [[
        vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 pixel_coords) {
         vec4 pixel = Texel(texture, texture_coords);
         pixel.r = floor(pixel.r+0.5);
         pixel.g = floor(pixel.g+0.5);
         pixel.b = floor(pixel.b+0.5);
         return  pixel;
      }
   ]]

   love.physics.setMeter(64) --the height of a meter our worlds will be 64px
   world = love.physics.newWorld(0, 9.81*64, true) --create a world for the bodies to exist in with horizontal gravity of 0 and vertical gravity of 9.81

   --let's create the ground
   ground = {}
   ground.body = love.physics.newBody(world, 800/2, 600-50/2) --remember, the shape (the rectangle we create next) anchors to the body from its center, so we have to move it to (650/2, 650-50/2)
   ground.shape = love.physics.newRectangleShape(800, 50) --make a rectangle with a width of 650 and a height of 50
   ground.fixture = love.physics.newFixture(ground.body, ground.shape); --attach shape to body

   --let's create a ball
   balls = {}
   for i=1, 300, 1 do
      local x = math.random(-100, 100)
      local y = math.random(-100, 100)
      balls[i] = {}
      balls[i].body = love.physics.newBody(world, 800/2 + x, 600/2 + y, "dynamic") --place the body in the center of the world and make it dynamic, so it can move around
      balls[i].body:setMass(75) --give it a mass of 15
      balls[i].shape = love.physics.newCircleShape(2.75) --the ball's shape has a radius of 10
      balls[i].fixture = love.physics.newFixture(balls[i].body, balls[i].shape, 10) --attach shape to body and give it a friction of 1
      balls[i].fixture:setRestitution(.9) --let the ball bounce
   end
end


function love.update(dt)
   world:update(dt) --this puts the world into motion
end

function love.draw()
   canv:clear(0,0,0,0)
   love.graphics.setBlendMode("additive")
   love.graphics.setCanvas(canv)
   
   for i=1, 100, 1 do
      love.graphics.draw(mb_img, balls[i].body:getX(), balls[i].body:getY())
   end

   love.graphics.setBlendMode("alpha")
   love.graphics.setCanvas()

   love.graphics.setPixelEffect(effect)
   love.graphics.draw(canv,0,0,0,1,1,0,0,0,0)
   love.graphics.setPixelEffect()

   love.graphics.setColor(255,255,255,255)
   love.graphics.print(love.timer.getFPS(),32,32,0,1,1,0,0,0,0)
end