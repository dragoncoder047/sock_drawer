:Input "DY/DX= ",Str1
:ClrDraw
:For(X,Xmin,Xmax)
:For(Y,Ymin,Ymax)
:expr(Str1)→M
:tan⁻¹(M)→θ
:Line(X-cos(θ)/2,Y-sin(θ)/2,X+cos(θ)/2,Y+sin(θ)/2,1,BLUE)
:End
:End
:Input
:While 1
:expr(Str1)→M
:tan⁻¹(M)→θ
:X→A
:Y→B
:X+cos(θ)/8→X
:Y+sin(θ)/8→Y
:Line(A,B,X,Y,1,MAGENTA)
:End
