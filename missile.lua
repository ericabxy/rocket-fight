local missile = {
  right = 320,
  bottom = 240,
  x = 0,
  y = 0,
  radius = 5,
  angle = 0,
  speed = 100,
}

function missile:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

function missile:segment(n)
  n = n or 360
  return math.floor(self.angle * (n / 2 / math.pi))
end

function missile:translate(dt)
  self.x = self.x + math.cos(self.angle) * self.speed * dt
  self.y = self.y + math.sin(self.angle) * self.speed * dt
  self.x = (self.x+self.radius) % (self.right+self.radius*2) - self.radius
  self.y = (self.y+self.radius) % (self.bottom+self.radius*2) - self.radius
end

return missile
