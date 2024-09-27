:Disp "If AX²+BX+C=0"
:Disp "Then X=(⁻B+√(B²-4AC))/(2A)"
:Disp " or  X=(⁻B-√(B²-4AC))/(2A)"
:Disp ""
:Input "A= ",A
:Input "B= ",B
:Input "C= ",C
:Disp "B²="
:Disp B²
:Disp "-4AC="
:Disp ⁻4AC
:If B²-4AC<0
:Then
:Disp "DISCRIMINANT IS NEGATIVE"
:Disp "NO REAL ANSWERS"
:a+b𝑖
:End
:Disp "√(B²-4AC)="
:Disp √(B²-4AC)
:Disp "X="
:2→dim(ʟX)
:(⁻B+√(B²-4AC))/(2A)→ʟX(1)
:(⁻B-√(B²-4AC))/(2A)→ʟX(2)
:ʟX
