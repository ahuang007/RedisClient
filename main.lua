package.path = "./?.lua;" .. package.path

local redis = require 'redis'
local redisClient 
local redisConfig = {
	host = '10.10.2.63',
	port = 6379,
	db   = 1,
}

local function connectRedis()
	redisClient = redis.connect(redisConfig)
	redisClient:select(redisConfig.db)
end 

local keys
function love.load() --��Դ���ػص�����������ʼ��ʱ����һ��
	connectRedis()
	-- redisClient:set('test', '1111111')
	-- local value = redisClient:get('test')
	-- love.window.showMessageBox("testRedis", value)
end

local function useDefaultFont(text, x, y, size)
	love.graphics.setColor(255,0,0)
	love.graphics.setBlendMode("alpha")
	local font = love.graphics.newFont( size )
	love.graphics.setFont(font)
	love.graphics.print(text,x,y+size)

end

function love.draw() --��ͼ�ص�������ÿ���ڵ���
	love.graphics.setBlendMode("alpha")
	love.graphics.setColor(255, 255, 255)
	love.graphics.rectangle("fill", 0, 0, 800, 600)

	love.graphics.setColor(0, 0, 0)
	love.graphics.line(200, 0, 200, 600)

	love.graphics.setColor(0, 0, 0)
	love.graphics.rectangle("line", 0, 0, 800, 600)

	keys = redisClient:keys('*')
	table.sort(keys, function(a, b) return a < b end) -- key����
	local len = #keys
	local keyHight = 30
	for i = 1, len do
		love.graphics.setColor(0, 0, 255)
		love.graphics.rectangle("line", 0,  (i - 1) * keyHight, 200, 30)
		useDefaultFont(keys[i], 20 , 2 + (i - 1) * keyHight, 10)
	end
end

function love.update(dt) --���»ص�������ÿ���ڵ���

end

function love.keypressed(key) --���̼��ص��������������¼������ǵ���

end