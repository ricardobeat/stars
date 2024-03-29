canvas = document.createElement 'canvas'
  
document.body.appendChild canvas
canvas.width = window.innerWidth
canvas.height = window.innerHeight
  
canvas.style.background = '#333436'
  
ctx = canvas.getContext '2d'

dot = (x, y, opacity=1) ->
  ctx.fillStyle = "rgba(#{[255,255,255,opacity]})"
  ctx.beginPath()
  ctx.arc x, y, 1, 0, Math.PI*2, true
  ctx.closePath()
  ctx.fill()
    
distance = (x1, y1, x2, y2) ->
  xs = Math.pow(x2 - x1, 2)
  ys = Math.pow(y2 - y1, 2)
  return Math.sqrt xs + ys
    
s1 = 10
s2 = s1*2
s4 = s1*4
sh = s1/2
  
dots = 10
  
maxDistance = distance(0, 0, dots * 0.5 * s1, dots * 0.5 * s1)
  
drawDots = (x, y, px, py) ->
  for i in [0..10]
    offsetX = (i * s1) - s4
    for j in [0..10]
      offsetY = (j * s1) - s4
      dx = x + offsetX
      dy = y + offsetY
      if dy % s2 is 0 then dx -= 5
      opacity = 0.7 - (distance(dx, dy, px, py) / maxDistance).toFixed(2)
      dot dx, dy, opacity
    
document.addEventListener 'mousemove', (e) ->
  x = Math.floor(e.pageX/s1)*s1
  y = Math.floor(e.pageY/s1)*s1
  ctx.clearRect Math.max(0, x-200), Math.max(0, y-200), x+200, y+200
  drawDots x, y, e.pageX, e.pageY
