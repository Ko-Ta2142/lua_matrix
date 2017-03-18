
-- matrix math library

matrix={}

matrix.invradius= 1*math.pi/180

matrix.rotatemode = {}
matrix.rotatemode.pass = 0
matrix.rotatemode.xyz = 1
matrix.rotatemode.xzy = 2
matrix.rotatemode.yxz = 3
matrix.rotatemode.yzx = 4
matrix.rotatemode.zxy = 5
matrix.rotatemode.zyx = 6

-- vertex

function matrix.newvertex4()
	local t = {
		x=0.0 , y=0.0 , z=0.0 , w=1.0
	}
	return t
end

function matrix.newvertex3()
	local t = {
		x=0.0 , y=0.0 , z=0.0
	}
	return t
end

-- matrix class

cmatrix4 = {}

function cmatrix4:new()
	local t = {
		1.0 , 0.0 , 0.0 , 0.0 ,
		0.0 , 1.0 , 0.0 , 0.0 ,
		0.0 , 0.0 , 1.0 , 0.0 ,
		0.0 , 0.0 , 0.0 , 1.0
	}

	setmetatable(t , cmatrix4.metatable)
	return t
end
function cmatrix4:destructor()
	--
end
cmatrix4.metatable = {__index=cmatrix4 , __gc=cmatrix4.destructor}

function cmatrix4:identity()
	self[1+0] = 1.0		self[2+0] = 0.0		self[3+0] = 0.0		self[4+0] = 0.0
	self[1+4] = 0.0		self[2+4] = 1.0		self[3+4] = 0.0		self[4+4] = 0.0
	self[1+8] = 0.0		self[2+8] = 0.0		self[3+8] = 1.0		self[4+8] = 0.0
	self[1+12] = 0.0	self[2+12] = 0.0	self[3+12] = 0.0	self[4+12] = 1.0
end

function cmatrix4:rotatex(r)
	local s = math.sin(r)
	local c = math.cos(r)
	self[1+0] = 1.0		self[2+0] = 0.0		self[3+0] = 0.0		self[4+0] = 0.0
	self[1+4] = 0.0		self[2+4] = c		self[3+4] = s		self[4+4] = 0.0
	self[1+8] = 0.0		self[2+8] = -s		self[3+8] = c		self[4+8] = 0.0
	self[1+12] = 0.0	self[2+12] = 0.0	self[3+12] = 0.0	self[4+12] = 1.0
end

function cmatrix4:rotatey(r)
	local s = math.sin(r)
	local c = math.cos(r)
	self[1+0] = c		self[2+0] = 0.0		self[3+0] = -s		self[4+0] = 0.0
	self[1+4] = 0.0		self[2+4] = 1.0		self[3+4] = 0.0		self[4+4] = 0.0
	self[1+8] = s		self[2+8] = 0.0		self[3+8] = c		self[4+8] = 0.0
	self[1+12] = 0.0	self[2+12] = 0.0	self[3+12] = 0.0	self[4+12] = 1.0
end

function cmatrix4:rotatez(r)
	local s = math.sin(r)
	local c = math.cos(r)
	self[1+0] = c		self[2+0] = s		self[3+0] = 0.0		self[4+0] = 0.0
	self[1+4] = -s		self[2+4] = c		self[3+4] = 0.0		self[4+4] = 0.0
	self[1+8] = 0.0		self[2+8] = 0.0		self[3+8] = 1.0		self[4+8] = 0.0
	self[1+12] = 0.0	self[2+12] = 0.0	self[3+12] = 0.0	self[4+12] = 1.0
end

function cmatrix4:scale(x,y,z)
	self[1+0] = x		self[2+0] = 0.0		self[3+0] = 0.0		self[4+0] = 0.0
	self[1+4] = 0.0		self[2+4] = y		self[3+4] = 0.0		self[4+4] = 0.0
	self[1+8] = 0.0		self[2+8] = 0.0		self[3+8] = z		self[4+8] = 0.0
	self[1+12] = 0.0	self[2+12] = 0.0	self[3+12] = 0.0	self[4+12] = 1.0
end

function cmatrix4:translate(x,y,z)
	self[1+0] = 1.0		self[2+0] = 0.0		self[3+0] = 0.0		self[4+0] = 0.0
	self[1+4] = 0.0		self[2+4] = 1.0		self[3+4] = 0.0		self[4+4] = 0.0
	self[1+8] = 0.0		self[2+8] = 0.0		self[3+8] = 1.0		self[4+8] = 0.0
	self[1+12] = x		self[2+12] = y		self[3+12] = z		self[4+12] = 1.0
end

function cmatrix4:composite(m2)
	local h1,h2,h3,h4

	h1 = self[1+0]
	h2 = self[2+0]
	h3 = self[3+0]
	h4 = self[4+0]
	self[1+0] = h1*m2[1+0] + h2*m2[1+4] + h3*m2[1+8] + h4*m2[1+12]
	self[2+0] = h1*m2[2+0] + h2*m2[2+4] + h3*m2[2+8] + h4*m2[2+12]
	self[3+0] = h1*m2[3+0] + h2*m2[3+4] + h3*m2[3+8] + h4*m2[3+12]
	self[4+0] = h1*m2[4+0] + h2*m2[4+4] + h3*m2[4+8] + h4*m2[4+12]

	h1 = self[1+4]
	h2 = self[2+4]
	h3 = self[3+4]
	h4 = self[4+4]
	self[1+4] = h1*m2[1+0] + h2*m2[1+4] + h3*m2[1+8] + h4*m2[1+12]
	self[2+4] = h1*m2[2+0] + h2*m2[2+4] + h3*m2[2+8] + h4*m2[2+12]
	self[3+4] = h1*m2[3+0] + h2*m2[3+4] + h3*m2[3+8] + h4*m2[3+12]
	self[4+4] = h1*m2[4+0] + h2*m2[4+4] + h3*m2[4+8] + h4*m2[4+12]

	h1 = self[1+8]
	h2 = self[2+8]
	h3 = self[3+8]
	h4 = self[4+8]
	self[1+8] = h1*m2[1+0] + h2*m2[1+4] + h3*m2[1+8] + h4*m2[1+12]
	self[2+8] = h1*m2[2+0] + h2*m2[2+4] + h3*m2[2+8] + h4*m2[2+12]
	self[3+8] = h1*m2[3+0] + h2*m2[3+4] + h3*m2[3+8] + h4*m2[3+12]
	self[4+8] = h1*m2[4+0] + h2*m2[4+4] + h3*m2[4+8] + h4*m2[4+12]

	h1 = self[1+12]
	h2 = self[2+12]
	h3 = self[3+12]
	h4 = self[4+12]
	self[1+12] = h1*m2[1+0] + h2*m2[1+4] + h3*m2[1+8] + h4*m2[1+12]
	self[2+12] = h1*m2[2+0] + h2*m2[2+4] + h3*m2[2+8] + h4*m2[2+12]
	self[3+12] = h1*m2[3+0] + h2*m2[3+4] + h3*m2[3+8] + h4*m2[3+12]
	self[4+12] = h1*m2[4+0] + h2*m2[4+4] + h3*m2[4+8] + h4*m2[4+12]
end

function cmatrix4:transform(v)
	local x,y,z

	x = v.x
	y = v.y
	z = v.z
	v.x = x*self[1+0] + y*self[1+4] + z*self[1+8] + self[1+12]
	v.y = x*self[2+0] + y*self[2+4] + z*self[2+8] + self[2+12]
	v.z = x*self[3+0] + y*self[3+4] + z*self[3+8] + self[3+12]
end

-- optimize function

function cmatrix4:pushrotatex(r)
	if r == 0.0 then return end
	-- self[2+4] = c		self[3+4] = s
	-- self[2+8] = -s		self[3+8] = c

	local s = math.sin(r)
	local c = math.cos(r)
	local h2,h3

	h2 = self[2+0]
	h3 = self[3+0]
	self[2+0] = h2*c + h3*-s
	self[3+0] = h2*s + h3*c

	h2 = self[2+4]
	h3 = self[3+4]
	self[2+4] = h2*c + h3*-s
	self[3+4] = h2*s + h3*c

	h2 = self[2+8]
	h3 = self[3+8]
	self[2+8] = h2*c + h3*-s
	self[3+8] = h2*s + h3*c

	h2 = self[2+12]
	h3 = self[3+12]
	self[2+12] = h2*c + h3*-s
	self[3+12] = h2*s + h3*c
end

function cmatrix4:pushrotatey(r)
	if r == 0.0 then return end
	-- self[1+0] = c		self[3+0] = -s
	-- self[1+8] = s		self[3+8] = c

	local s = math.sin(r)
	local c = math.cos(r)
	local h1,h3

	h1 = self[1+0]
	h3 = self[3+0]
	self[1+0] = h1*c + h3*s
	self[3+0] = h1*-s + h3*c

	h1 = self[1+4]
	h3 = self[3+4]
	self[1+4] = h1*c + h3*s
	self[3+4] = h1*-s + h3*c

	h1 = self[1+8]
	h3 = self[3+8]
	self[1+8] = h1*c + h3*s
	self[3+8] = h1*-s + h3*c

	h1 = self[1+12]
	h3 = self[3+12]
	self[1+12] = h1*c + h3*s
	self[3+12] = h1*-s + h3*c
end

function cmatrix4:pushrotatez(r)
	if r == 0.0 then return end
	-- self[1+0] = c		self[2+0] = s
	-- self[1+4] = -s		self[2+4] = c
	
	local s = math.sin(r)
	local c = math.cos(r)
	local h1,h2

	h1 = self[1+0]
	h2 = self[2+0]
	self[1+0] = h1*c + h2*-s
	self[2+0] = h1*s + h2*c

	h1 = self[1+4]
	h2 = self[2+4]
	self[1+4] = h1*c + h2*-s
	self[2+4] = h1*s + h2*c

	h1 = self[1+8]
	h2 = self[2+8]
	self[1+8] = h1*c + h2*-s
	self[2+8] = h1*s + h2*c

	h1 = self[1+12]
	h2 = self[2+12]
	self[1+12] = h1*c + h2*-s
	self[2+12] = h1*s + h2*c
end

function cmatrix4:pushscale(x,y,z)
	if (x == 1.0)and(y == 1.0)and(z == 1.0)then return end
	--m2[1+0] = x
	--m2[2+4] = y
	--m2[3+8] = z

	self[1+0] = self[1+0]*x
	self[2+0] = self[2+0]*y
	self[3+0] = self[3+0]*z

	self[1+4] = self[1+4]*x
	self[2+4] = self[2+4]*y
	self[3+4] = self[3+4]*z

	self[1+8] = self[1+8]*x
	self[2+8] = self[2+8]*y
	self[3+8] = self[3+8]*z

	self[1+12] = self[1+12]*x
	self[2+12] = self[2+12]*y
	self[3+12] = self[3+12]*z
end

function cmatrix4:pushtranslate(x,y,z)
	if (x == 0.0)and(y == 0.0)and(z == 0.0) then return end
	-- m2[1+0]=1.0
	-- 					m2[2+4]=1.0
	-- 										m2[3+8]=1.0
	-- m2[1+12] = x		m2[2+12] = y		m2[3+12] = z		m2[4+12]=1.0

	local h4

	h4 = self[4+0]
	self[1+0] = self[1+0] + h4*x
	self[2+0] = self[2+0] + h4*y
	self[3+0] = self[3+0] + h4*z

	h4 = self[4+4]
	self[1+4] = self[1+4] + h4*x
	self[2+4] = self[2+4] + h4*y
	self[3+4] = self[3+4] + h4*z

	h4 = self[4+8]
	self[1+8] = self[1+8] + h4*x
	self[2+8] = self[2+8] + h4*y
	self[3+8] = self[3+8] + h4*z

	h4 = self[4+12]
	self[1+12] = self[1+12] + h4*x
	self[2+12] = self[2+12] + h4*y
	self[3+12] = self[3+12] + h4*z
end


function cmatrix4:pushrotate(x,y,z , mode)
	if mode == nil then mode = cmatrix.rotatemode.xyz end
	if mode == cmatrix.rotatemode.pass then mode = cmatrix.rotatemode.xyz end

	-- xyz,xzy
	if (mode == 1)or(mode == 2)then 
		self:pushrotatex(x)
		if mode == 1 then
			self:pushrotatey(y)
			self:pushrotatez(z)
		else
			self:pushrotatez(z)
			self:pushrotatey(y)
		end
		return
	end
	-- yxz,yzx
	if (mode == 3)or(mode == 4)then
		self:pushrotatey(y)
		if mode == 3 then
			self:pushrotatex(x)
			self:pushrotatez(z)
		else
			self:pushrotatez(z)
			self:pushrotatex(x)
		end
	end
	-- zxy,zyx
	if (mode == 5)or(mode == 6)then
		self:pushrotatez(z)
		if mode == 5 then
			self:pushrotatex(x)
			self:pushrotatey(y)
		else
			self:pushrotatey(y)
			self:pushrotatex(x)
		end
	end
end

--[[
function cmatrix.matrix4composite(self,m2)
	local t = {
		self[1+0]*m2[1+0] + self[2+0]*m2[1+4] + self[3+0]*m2[1+8] + self[4+0]*m2[1+12],
		self[1+0]*m2[2+0] + self[2+0]*m2[2+4] + self[3+0]*m2[2+8] + self[4+0]*m2[2+12],
		self[1+0]*m2[3+0] + self[2+0]*m2[3+4] + self[3+0]*m2[3+8] + self[4+0]*m2[3+12],
		self[1+0]*m2[4+0] + self[2+0]*m2[4+4] + self[3+0]*m2[4+8] + self[4+0]*m2[4+12],

		self[1+4]*m2[1+0] + self[2+4]*m2[1+4] + self[3+4]*m2[1+8] + self[4+4]*m2[1+12],
		self[1+4]*m2[2+0] + self[2+4]*m2[2+4] + self[3+4]*m2[2+8] + self[4+4]*m2[2+12],
		self[1+4]*m2[3+0] + self[2+4]*m2[3+4] + self[3+4]*m2[3+8] + self[4+4]*m2[3+12],
		self[1+4]*m2[4+0] + self[2+4]*m2[4+4] + self[3+4]*m2[4+8] + self[4+4]*m2[4+12],

		self[1+8]*m2[1+0] + self[2+8]*m2[1+4] + self[3+8]*m2[1+8] + self[4+8]*m2[1+12],
		self[1+8]*m2[2+0] + self[2+8]*m2[2+4] + self[3+8]*m2[2+8] + self[4+8]*m2[2+12],
		self[1+8]*m2[3+0] + self[2+8]*m2[3+4] + self[3+8]*m2[3+8] + self[4+8]*m2[3+12],
		self[1+8]*m2[4+0] + self[2+8]*m2[4+4] + self[3+8]*m2[4+8] + self[4+8]*m2[4+12],

		self[1+12]*m2[1+0] + self[2+12]*m2[1+4] + self[3+12]*m2[1+8] + self[4+12]*m2[1+12],
		self[1+12]*m2[2+0] + self[2+12]*m2[2+4] + self[3+12]*m2[2+8] + self[4+12]*m2[2+12],
		self[1+12]*m2[3+0] + self[2+12]*m2[3+4] + self[3+12]*m2[3+8] + self[4+12]*m2[3+12],
		self[1+12]*m2[4+0] + self[2+12]*m2[4+4] + self[3+12]*m2[4+8] + self[4+12]*m2[4+12]
	}
	return t
end
]]

