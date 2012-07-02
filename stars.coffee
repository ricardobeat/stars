canvas = document.createElement 'canvas'
  
document.body.appendChild canvas
canvas.width = window.innerWidth
canvas.height = window.innerHeight
  
canvas.style.background = '#333436'
  
ctx = canvas.getContext '2d'

dot = (x, y, opacity=1) ->
  ctx.fillStyle = "rgba(#{[255,255,255,opacity]})"
  ctx.beginPath()
  ctx.arc x, y, (1 + opacity * 2), 0, Math.PI*2, true
  ctx.closePath()
  ctx.fill()
    
distance = (x1, y1, x2, y2) ->
  xs = Math.pow(x2 - x1, 2)
  ys = Math.pow(y2 - y1, 2)
  return Math.sqrt xs + ys
    
s1 = if screen.width > 1024 then 12 else 16
s2 = s1*2
s4 = s1*4
sh = s1/2
  
dots = 10
  
maxDistance = distance(0, 0, dots * 0.5 * s1, dots * 0.5 * s1)
  
drawDots = (px, py) ->
  x = Math.floor(px/s1) * s1
  y = Math.floor(py/s1) * s1
  for i in [0..dots]
    offsetX = (i * s1) - s4
    for j in [0..dots]
      offsetY = (j * s1) - s4
      dx = x + offsetX
      dy = y + offsetY
      if dy % s2 is 0 then dx -= 5
      opacity = 0.7 - (distance(dx, dy, px, py) / maxDistance).toFixed(2)
      dot dx, dy, opacity

update = (e) ->
  e.preventDefault()
  e.stopPropagation()
  [x,y] = [0,0]
  if not e.touches?
    e.touches = [{ pageX: e.pageX, pageY: e.pageY }]
  for touch in e.touches
    [x,y] = [touch.pageX, touch.pageY]
    ctx.clearRect Math.max(0, x-200), Math.max(0, y-200), x+200, y+200
  for touch in e.touches
    drawDots touch.pageX, touch.pageY

clear = (e) ->
  ctx.clearRect 0, 0, canvas.width, canvas.height

document.addEventListener 'mousemove', update, false
document.addEventListener 'touchmove', update, false
document.addEventListener 'touchend', clear, false
