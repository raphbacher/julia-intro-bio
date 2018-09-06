using Interact, Blink
using Plots

function draw_ui()
x = y = 0:0.1:30

freqs = OrderedDict(zip(["pi/4", "π/2", "3π/4", "π"], [π/4, π/2, 3π/4, π]))

mp = @manipulate for freq1 in freqs, freq2 in slider(0.01:0.1:4π; label="freq2")
    y = @. sin(freq1*x) * sin(freq2*x)
    plot(x, y)
end
return mp
end
#WebIO.webio_serve(page("/", req -> mp), 8000) # serve on a random port
w = Window()
body!(w, draw_ui());
