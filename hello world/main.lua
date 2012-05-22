function love.load()
	love.graphics.setBackgroundColor( 0, 0, 0 )
	print("lolwut")
end

a1 =400
a2=0
a=0
b=0
v = {{x=0,y=0},{x=0,y=0},{x=0,y=0},{x=0,y=0}, {x=0,y=0}, {x=0,y=0}, {x=0,y=0}, {x=0,y=0}, {x=0,y=0}, {x=0,y=0}, {x=0,y=0}}

function love.draw()
	h,j= love.mouse.getPosition();
	love.graphics.setColor( 0, 255, 0, 255 )
	love.graphics.rectangle( "fill", a,  b, 129, 64 )
		
	a2=a2+(a1-a2)*0.01;
	love.graphics.setColor( 255, 0, 0, 255 )
	love.graphics.rectangle( "fill", 300,  200, 129, a2 )
	
	love.graphics.setColor( 0, 0, 255, 255 )
	love.graphics.rectangle( "fill", h,  j, 129, 64 )

	v[1].x = v[1].x+(h-v[1].x)*0.06
	v[1].y = v[1].y+(j-v[1].y)*0.06
	
	for i=2, 11 do
		v[i].x = v[i].x+(v[i-1].x-v[i].x)*0.06
		v[i].y = v[i].y+(v[i-1].y-v[i].y)*0.06
		
		love.graphics.setColor( 64, 211, 120, 255 - i * 10)
		love.graphics.rectangle( "fill", v[i].x,  v[i].y, 20, 20 )
	end

	
end 

function love.update(dt)

end

function love.focus(bool)

end

function love.keypressed (key, unicode)
	print("yo pressed" .. key)
end

function love.keyreleased (key, unicode)
	print("yo relesed " .. key)
end

function love.mousepressed ( x, y, button )
	print(x," ", y, " ", button);
	a=x;
	b=y;
	if(button == 'r') then
		a2=20;
	end
	love.draw(x+20, y, button);
end

function love.mousereleased ( x, y, button )

end

function love.quit()

end
