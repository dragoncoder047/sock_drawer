:Lbl 0
:Input "NUMBER: ",N
:If N<4
:Menu("NUMBER MUST BE ≥4","OK",E)
:If int(N)≠N
:Menu("NUMBER MUST BE INTEGER","OK",E)
:Goto J
:Lbl E
:Disp "Invaʟ𝑖d Input "
:Goto 0
:Lbl J
:0→C
:getTime→ʟC
:{2,1}→dim([F])
:0.2→[F](1,1)
:For(I,1,int(√(N)))
:If (N/I)=int(N/I)
:Then
:1+C→C
:{2,C}→dim([F])
:I→[F](1,C)
:N/I→[F](2,C)
:End
:End
:Disp "TIME FOR CALCULATION:"
:ʟC(3)→T
:getTime→ʟC
:ʟC(3)→U
:U-T→D
:Disp D+60(D<0)
:If C=1
:Disp "N IS PRIME"
:Disp "FACTORS:"
:[F]

