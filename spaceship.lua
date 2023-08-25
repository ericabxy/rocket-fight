--[[
Copyright 2023 Eric Duhamel

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

"spaceship.lua" is a physics library for managing a rocketship akin to
the original *Spacewar!* and derivatives like *Galaxy Game*, *Computer
Space*, and *Asteroids*.
--]]

local spaceship = {
  right = 320,
  bottom = 240,
  x = 0,
  y = 0,
  radius = 16,
  dx = 0,
  dy = 0,
  angle = 0,
  turnrate = 2.5,
  speed = 25,
}

function spaceship:accelerate(dt)
  self.dx = self.dx + math.cos(self.angle) * self.speed * dt
  self.dy = self.dy + math.sin(self.angle) * self.speed * dt
end

function spaceship:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

function spaceship:nose(d)
  d = d or self.radius
  return self.x + math.cos(self.angle) * d,
         self.y + math.sin(self.angle) * d
end

function spaceship:rotate(dt)
  self.angle = self.angle + self.turnrate * dt
  self.angle = self.angle % (2 * math.pi)
end

function spaceship:segment(n)
  n = n or 360
  return math.floor(self.angle * (n / 2 / math.pi))
end

function spaceship:tail(d, x, y)
  d = d or self.radius
  x = x or 0
  y = y or 0
  return self.x - math.cos(self.angle) * d + x,
         self.y - math.sin(self.angle) * d + y
end

function spaceship:translate(dt)
  self.x = self.x + self.dx * dt
  self.y = self.y + self.dy * dt
  self.x = (self.x+self.radius) % (self.right+self.radius*2) - self.radius
  self.y = (self.y+self.radius) % (self.bottom+self.radius*2) - self.radius
end

return spaceship