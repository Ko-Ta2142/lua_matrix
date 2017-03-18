# lua fast matrix
4x4行列composite最適化コード。  
移動、回転、伸縮を行列に反映させます。  
回転行列を求めて行列同士を結合する場合に比べると格段に計算が減ります。

fast(Optimization) 4x4matrix composite.  
translate,rotate,scale and composite.

## sample

```lua
local m = cmatrix4:new()
-- rotate
m:pushrotate(90,90,90)
-- scale
m:pushscale(1,1,2)
-- move
m:pushtranslate(320,320,20)
-- vertex calc
local v = matrix.newvertex3()
v.x = 20
v.y = 20
v.z = 20
m:transform(v) --output v
```