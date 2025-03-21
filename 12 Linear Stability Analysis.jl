### A Pluto.jl notebook ###
# v0.20.0

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
end

# ╔═╡ 2e6401b9-9c89-4b4b-8492-d0a83003579b
using Plots, PlutoUI, ParameterizedFunctions, DifferentialEquations

# ╔═╡ 8ba695de-0650-407c-864a-c394c9c7d3ed
html"<button onclick='present()'>present</button>"

# ╔═╡ 0102b1ee-7f41-4400-aef3-c33e18b5b716
begin
	struct Foldable{C}
	    title::String
	    content::C
	end
	
	function Base.show(io, mime::MIME"text/html", fld::Foldable)
	    write(io,"<details><summary>$(fld.title)</summary><p>")
	    show(io, mime, fld.content)
	    write(io,"</p></details>")
	end
end

# ╔═╡ df36d23e-3760-48c1-8c0c-d52f15e7f520
md" ## Equilibrium And Stability 

Differential equations derived for these systems of interacting entities quickly become impossible to solve analitically. Therefore we have to use other mathematical tools to study them. The most common in the context of nonlineat dynamical systems is called 'Linear Stability Analysis'. 
"

# ╔═╡ 0b0440bf-4f75-47bd-bbd8-315066e79c75
Resource("https://www.researchgate.net/publication/346614443/figure/fig11/AS:964859927728140@1607051941592/Classification-of-fixed-points-for-two-dimensional-nonlinear-systems-As-a-function-of.png")

# ╔═╡ 279eaa4f-41ca-4168-b492-f36543bb8204
md"
##

Linear stability analysis is a method that allows us to study how a system behaves near an equilibrium point. It will help us to know if equilibrium is stable or unstable, and the bifurcations that occur in these equilibrium points, based only on a simplified linearized version of the system of study:

The model for Logistic Growth is simple enough that it can be solved analytically, but let's illustrate how linear stability analysis works this with the logistic model,.

```math
\begin{align*}
\frac{\mathrm{d} N}{\mathrm{d} t}=\mu N(1 -\frac{N}{K}) \tag{17}
\end{align*}
```
##

The main equation can be written in the following generic form:

```math
\begin{eqnarray}
\frac{\partial N}{\partial t} = f(N) 
\end{eqnarray}
```

where N is a variable and $f(N)$  is a functions which governs its temporal evolution. 
##
The first step is to calculate the fixed points of Eq. \ref{base1}. In continuous systems, the steady states occur when there is no change in the amount of our quantity $N$

```math
\begin{eqnarray}
\frac{\partial \overline{N}}{\partial t} = 0 = f(\overline{N})
\end{eqnarray}
```

Where we denote $\overline{N}$ as the value of our variable in steady state."

# ╔═╡ 00037d0a-8be0-4c75-94bc-23c2c639e6e8
md" 
##
Let's find the equilibrium points of our logistic model. 

```math
\begin{align*}
\frac{\mathrm{d} N}{\mathrm{d} t}= \mu N(1 -\frac{N}{K}) \tag{17}
\end{align*}
```

##
By taking the derivate to zero:

```math
\begin{align*}
\frac{\mathrm{d} \overline{N}}{\mathrm{d} t}=0= \mu \overline{N}(1 -\frac{\overline{N}}{K}) \tag{17}
\end{align*}
```
##
 we can easily see that we have two equilibrium states: 
```math
\begin{align*}
\overline{N}=0\\
1 -\frac{\overline{N}}{K} = 0 \Rightarrow \overline{N} = K
\end{align*}
```


"

# ╔═╡ 64dc539b-b268-43b6-a96e-2c4fa7b48474
md" The next step after finding the equilibrium points is to check if they are stable or unstable, or what type of equilibrium we have. We do that by introducing small perturbations.
##
Let’s take a fixed point $\overline{N}$ and perturb it by an infinitesimal amount n. We are interested in the dynamics of N = $\overline{N}$ + n and whether N will move away away or towards $\overline{N}$ as time progresses. 

```math
\begin{align*}
\frac{\mathrm{d} N}{\mathrm{d} t}= \frac{\mathrm{d} \overline{N} + n}{\mathrm{d} t}= \frac{\mathrm{d} \overline{N} }{\mathrm{d} t} + \frac{\mathrm{d} n}{\mathrm{d} t}
\end{align*}
```
##
and since 

```math
\begin{align*}
\frac{\mathrm{d} \overline{N} }{\mathrm{d} t} = 0 
\end{align*}
```

##
by definition, we have that the change in time of the population is equivalent to the change in the time of the small perturbation. 

```math
\begin{align*}
\frac{\mathrm{d} N}{\mathrm{d} t}= \frac{\mathrm{d} n}{\mathrm{d} t}
\end{align*}
```
##
Since $n$ is very small by definition, we can linearize the dynamics around the ficxed points $\overline{N}$, using a Taylor expansion
. 

```math
\begin{align*}
\frac{\mathrm{d} N}{\mathrm{d} t}= \frac{\mathrm{d} n}{\mathrm{d} t} = f(\overline{N}+n)= f(\overline{N})+ f'(\overline{N})·n +···
\end{align*}
```

being $f'(\overline{N})$ the value of derivative of function $f(N)$ in the point of equilibrium $\overline{N}$
##
Since $f(\overline{N})$ = 0 by definition, we get  

```math
\begin{align*}
 \frac{\mathrm{d} n}{\mathrm{d} t} = f'(\overline{N})·n +···
\end{align*}
```
"

# ╔═╡ f5faefd6-f496-40fb-8043-ef6b9d172ae0
md"

If the perturbation $n$ is very small, then linear and nonlinear evolution are in fact approximately the same. But as $n$ increases in size the nonlinear effects become increasingly more important and evolving y with the linearized dynamics or the full nonlinear dynamics is no longer equivalent. 

So, this means that if perturbations $n$ are small, we can forget about higher order terms and simply assume that this has a form of $\dot{n}= \lambda \cdot n$. 
##
So if we integrate we have a solution that is an exponential fucntion. 


```math
\begin{align*}
n(t)=n(0) e^{\lambda t}
\end{align*}
```
##
So, depending on the sign of $\lambda$, this perturbation $n$ may increase ($\lambda >0$) or decrease ($\lambda <0$). As an example, let's test this for the logistic system. 

```math
\begin{align*}
\frac{\mathrm{d} N}{\mathrm{d} t}=\mu N(1 -\frac{N}{K}) = \frac{\mathrm{d} (\mu \overline{N}(1 -\frac{\overline{N}}{K})}{\mathrm{d} t} n \tag{17}
\end{align*}
```
##
For simplicity, we will decompose the fucntion in to two terms:
```math
\begin{align*}
\mu N(1 -\frac{N}{K}) = g(N) \cdot h(N)
\end{align*}
```
##
being 


```math
\begin{align*}
g(N) &= \mu N \\
h(N) &= 1 -\frac{N}{K}
\end{align*}
```
##
now we need the detivative 
```math
\begin{align*}
\frac{\mathrm{d} [g(N) \cdot h(N)]}{\mathrm{d} t}= \frac{\mathrm{d} g(N) }{\mathrm{d} t}  h(N) + g(N) \frac{\mathrm{d} h(N) }{\mathrm{d} t} 
\end{align*}
```
##
since 
```math
\begin{align*}
\frac{\mathrm{d} g(N) }{\mathrm{d} t} &=\mu\\
\frac{\mathrm{d} h(N) }{\mathrm{d} t} &= -\frac{1}{K}
\end{align*}
```
##
so,

```math
\begin{align*}
\frac{\mathrm{d} (\mu N(1 -\frac{N}{K})}{\mathrm{d} t} =\mu (1 -\frac{N}{K}) - \frac{\mu \cdot N}{K}
\end{align*}
```

"

# ╔═╡ 32b3bc77-c4f4-40ab-a5a9-e035022189ac
md"
##
now we substitute our steady state values, for $\overline{N}=0$, we have 

```math
\begin{align*}
\frac{\mathrm{d} (\mu \overline{N}(1 -\frac{\overline{N}}{K})}{\mathrm{d} t}\Biggr\rvert_{\overline{N}=0} =\mu (1 -\frac{0}{K}) - \frac{\mu \cdot 0}{K} = \mu
\end{align*}
```
##
So, as long as $\mu > 0$ this fixed point is unestable. If we have $N=0$, the systems remains there. As soon as we perturb the number (and we can only perturb by slightly increasing, these perturbations grow exponentially. For the second steady state. 

```math
\begin{align*}
\frac{\mathrm{d} (\mu \overline{N}(1 -\frac{\overline{N}}{K})}{\mathrm{d} t}\Biggr\rvert_{\overline{N}=K} =\mu (1 -\frac{K}{K}) - \frac{\mu \cdot K}{K} = - \mu
\end{align*}
```
##
So, as long as $\mu > 0$ this fixed point is stable. Perturbations will allways decrease exponentially. 

To observe this grafically, lets plot the function $\mu N(1 -\frac{N}{K})$


"

# ╔═╡ c70c7a06-d1aa-40a9-902b-4bd4b23a6392
begin
	T_slide = @bind T html"<input type=range min=5 max=15 step=1>"
	K_slide = @bind K html"<input type=range min=100 max=500 step=10>"
	md"""
	**Set the Cell Cycle Length and the carrying capacity**
	
	value of T: $(T_slide) 
	value of K: $(K_slide)
	
	"""
end

# ╔═╡ 2cfd31c4-803a-4880-b2a4-5af6594c0975
begin
	N=collect(0:0.1:K);
	plot(N, log(2)/T .* N .* (1 .- (N ./ K)),label="T= $T, K= $K",seriestype=:line,xlabel=("N"),ylabel=("f(N)"),ylims = (0,20),xlims = (0,500))
end

# ╔═╡ 2170f883-1b01-4d16-907e-49c72118e224
md"
##
Equilibrium points are the values where the function is zero. We see the two of them, the unsable $\overline{N}=0$ and the stable $\overline{N}=K$. In this system, every perturbation moves away from $\overline{N}=0$ towards $\overline{N}=K$, which is the carrying capacity of the system.

The slope represents how fast the change occurs, so increasing $T$, means that we reach the carrying capacity of the system faster. 
##
So, this is a liner model, and we can solve it analitically, so performinng a perturbation analysis does not provide extra information (we now the full dynamics because we have an analitical solution). The advantage of this perturbation analysis (or linear stabilty analysis) is when we work with systems that cannot be solved anallyically, such as systems with multiple variables, and systems with nonlinearities. 

"

# ╔═╡ 7d89a7bd-baba-42c1-af4f-26f74138199a
md"## Stability analysis for the logistic growth with Allee effect

```math
\begin{align*}
\frac{\partial N}{\partial t}= \mu N \left(\frac{N}{A} -1\right) \left(1-\frac{N}{K}\right) 
\end{align*}
```



"

# ╔═╡ 9db950f3-6989-4225-845f-dae93d52a9b9
begin
	TT_slide = @bind TT html"<input type=range min=5 max=15 step=1>"
		KK_slide = @bind KK html"<input type=range min=100 max=500 step=10>"
		AA_slide = @bind AA html"<input type=range min=5 max=100 step=10>"
	
		md"""
		**Set the parameters**
		
		value of T: $(TT_slide) 
		value of K: $(KK_slide)
		value of A: $(AA_slide)
		
		"""
end

# ╔═╡ c620fb38-6e3d-4d54-b515-a9a5fc4360e4
begin
	#N=collect(0:0.1:K);
	plot(N, log(2)/TT  .* N .* (1 .- (N ./ KK)) .* ((N ./ AA) .-1 ),label="T= $TT, K= $KK, A = $AA",seriestype=:line,xlabel=("N"),ylabel=("f(N)"),ylims = (-5,10),xlims = (0,200))
end

# ╔═╡ 66ea1e28-b50a-43fc-acf5-9a146b51d505
md" 

```math
\begin{align*}
 \mu N \left(\frac{N}{A} -1 \right) \left(1-\frac{N}{K}\right) =0
\end{align*}
```

We have three fixed points, or points where the derivative is zero N=0, N=A and N=K. To calculate the stability we need the derivative  
```math
\begin{align*}
\frac{-A \cdot K + 2 \cdot A \cdot N + 2 \cdot K \cdot N - 3 \cdot N^2}{A \cdot K}
\end{align*}
```
"

# ╔═╡ b22fd4f1-ee14-4cb4-aff9-94153f470fe1
begin
		#N=collect(0:0.1:K);
		plot(N, 1 ./ 10 .* log(2)/TT  .* N .* (1 .- (N ./ KK)) .* ((N ./ AA) .-1 ),label="T= $T, K= $K",seriestype=:line,xlabel=("N"),ylabel=("f(N)"),ylims = (-5,10),xlims = (0,200))
		plot!(N, log(2)/TT  .* (-AA .* KK .+ 2 .* AA .* N .+ 2 .* KK .* N .- 3 .*N .^2) ./(AA .* KK),label="T= $TT, K= $KK",seriestype=:line,xlabel=("N"),ylabel=("f(N)"),ylims = (-1,1),xlims = (0,200))
end

# ╔═╡ 555aa5d3-9e29-459a-8798-51a576d252b4
md"At the firts fixed point $N=0$, wich means the extintion. so it is stable because the derivative is unstable.  At the secont fixed point, N=A is unstable, the derivative is positive at this point. The third one N=K is unstable again. "

# ╔═╡ 8c809d92-4edb-40ca-ac80-18b7e8c72fae
md"## 
> Exercise: Find the equilibrium and the stability of the logistic growth model with Allee effect and including a term that represents a constant loss of individuals due to harvesting. 
> 
>
>```math
>\begin{align*}
>\frac{\partial N}{\partial t}= \mu N \left(\frac{N}{A} -1\right) \left(1-\frac{N}{K}\right) - B
>\end{align*}
>```
> where B is the harvesting rate


"

# ╔═╡ 6c87979a-690a-400b-9ab8-7ef26b829195
md"## Stability analysis of nonlinear systems: Lotka-Volterra model

The Lotka-Volterra model, also known as Predator-Prey model describes the inteactions between two populations of species where one feeds into the other.  One can think of rabbits $x$ and foxes $y$, such that rabits multiply where there is no foxes (assuming an infinite amount of food for the rabbits). This is basically a first order production of rabbits, an autocalalitic system that results in exponetial growth of rabbits.
##

Next, foxes $y$ feed on the rabbits and multiply due to the good food conditions. Then also foxes die at a constant rate (rabbits also die, but the mdoel assumes that their rate of birth is much higher than the rate of death). The scheme of interactions for this very simple system is the following:

```math
\begin{align}
 x &\overset{k_1}{\longrightarrow} 2 x   \\
 x + y &\overset{k_2}{\longrightarrow} 2 y \\
 y &\overset{k_3}{\longrightarrow} 0 
 \end{align}
```
##
First, we find the differential equations that govern the dynamcis of the following system, and the steady state values. we start by writting the matrices of stoichiometric coefficients:

```math
A=\begin{bmatrix}
  1 & 0  \\  
  1 & 1   \\
  0 & 1       \end{bmatrix} ;
B=\begin{bmatrix}
  2 & 0   \\ 
  0 & 2   \\
  0 & 0       \end{bmatrix}; \tag{8}
```

"

# ╔═╡ 04c14475-24cd-49c3-8a7b-83a9425664be
A = [1 0;1 1;0 1];B = [2 0;0 2;0 0];(B-A)'

# ╔═╡ 919bf3e4-6aa0-440b-b76f-34a4812c6752
md"##
in this particular case

```math
K=\begin{pmatrix}
 k_1 & 0 & 0  \tag{9}\\ 
 0 &  k_2 & 0  \\ 
 0 &  0 & k_3 
\end{pmatrix}
```
##
and 


```math
X^A=\begin{pmatrix}
X_1^1\cdot X_2^0  \\
X_1^1\cdot X_2^1  \\
X_1^0\cdot X_2^1   
\end{pmatrix} = \begin{pmatrix}
 X_1 \\
 X_1 \cdot X_2\\
 X_2
\end{pmatrix} \tag{10}
```
##
so, the equations that define the system are

```math
\begin{align}
 \begin{bmatrix}
\frac{\mathrm{d} X_1}{\mathrm{d} t}\\ \frac{\mathrm{d} X_2}{\mathrm{d} t} \end{bmatrix}& 
=  \begin{bmatrix} 1 & -1 & 0  \\ 0 & 1 &  -1  \end{bmatrix}
\begin{pmatrix}
 k_1 & 0 & 0  \tag{9}\\ 
 0 &  k_2 & 0  \\ 
 0 &  0 & k_3 
\end{pmatrix}
 \begin{pmatrix}
 X_1 \\
 X_1 \cdot X_2\\
 X_2
\end{pmatrix} 
\end{align}
```
##
and after multiplying the matrices
```math
\begin{align}
 \begin{bmatrix}
\frac{\mathrm{d} X_1}{\mathrm{d} t}\\ \frac{\mathrm{d} X_2}{\mathrm{d} t} \end{bmatrix}& 
=  \begin{bmatrix} 1 & -1 & 0  \\ 0 & 1 &  -1  \end{bmatrix}
 \begin{pmatrix}
 k_1 \cdot X_1 \\
 k_2 \cdot X_1 \cdot X_2\\
 k_3 \cdot X_2
\end{pmatrix} 
\end{align}
```
##
so finally, 

```math
\begin{align}
 \begin{bmatrix}
\frac{\mathrm{d} X_1}{\mathrm{d} t}\\ \frac{\mathrm{d} X_2}{\mathrm{d} t} 
\end{bmatrix}&= 
 \begin{pmatrix}
   k_1 \cdot X_1 - k_2 \cdot X_1 \cdot X_2 \\
  k_2 \cdot X_1 \cdot X_2 - k_3 \cdot X_2
\end{pmatrix} \tag{11}
\end{align}
```
##
Therefore, the  equations for the evolution of `[x]` and `[y]` are as follows:

```math
\begin{align}       
            \frac{ dx }{dt} &=  k_1 \cdot x - k_2 \cdot x \cdot y  \tag{5}\\ 
            \frac{ dy }{dt} &= k_2 \cdot x \cdot y - k_3 \cdot y  \tag{6} 
            \end{align} 
```


"

# ╔═╡ 855b8530-861e-427e-b6cc-c1b0283568ca
md" 
##
which in general form, we can write as:

```math
\begin{eqnarray}
\frac{\partial x}{\partial t} = f(x, y) \\
\frac{\partial y}{\partial t} = g(x, y) 
\end{eqnarray}
```
##
where $f(x, y)$ and $g(x, y)$ are nonlinear equations that govern the temporal evolution and couple the behavior of the two variables $x$ and $y$:

Next, we need to calculate the fixed points:

```math
\begin{eqnarray}
\frac{\partial \overline{x}}{\partial t} =0= f(\overline{x},\overline{y})  \\
\frac{\partial \overline{y}}{\partial t}= 0 = g(\overline{x},\overline{y})
\end{eqnarray}
```
##
For the particular case of the Lotcka-Volterra, we just set eqs. 5 and 6 to zero



```math
\begin{align}       
            k_1 \cdot \overline{x} - k_2 \cdot \overline{x} \cdot \overline{y}  \tag{5} &= 0\\ 
            k_2 \cdot \overline{x} \cdot \overline{y} - k_3 \cdot \overline{y}  \tag{6} &= 0
            \end{align} 
```
##
and solve for `x` and `y`. We obtain two solutions,  $\overline{x}=\overline{y}=0$ and 


```math
\begin{align}       
            \overline{x} &= \frac{k_3}{k_2}\tag{5} \\ 
            \overline{y} &= \frac{k_1}{k_2} \tag{6}   
            \end{align}    
```


	"

# ╔═╡ c112e62c-9c38-48dc-8294-42911b02ccc5
md" ##
The next step is to find the characteristics of the steady states. We do that by following the same rationalle of the logistic model, i.e., to expand our equations as Taylor series around the steady state $(\overline{x},\overline{y})$., but now for multi-variable equations. 

```math
\begin{eqnarray}
\frac{\partial x}{\partial t} = M_{11} \cdot x + M_{12} \cdot y + ... \\
\frac{\partial y}{\partial t} = M_{21} \cdot x + M_{22} \cdot y + ... 
\end{eqnarray}
```
##            
Where $M_{ij}$ are the components of the Jacobian matrix, evaluated at the steady state $(\overline{x},\overline{y})$. 

```math
\begin{align}
 J=\begin{bmatrix} 
 M_{11} & M_{12} \\ 
 M_{21} & M_{22}
 \end{bmatrix}_{\overline{x},\overline{y}}= \begin{bmatrix} 
\frac{\partial  f(x,y)}{\partial x}\Biggr\rvert_{\overline{x},\overline{y}} & \frac{\partial  f(x,y)}{\partial y}\Biggr\rvert_{\overline{x},\overline{y}} \\ 
\frac{\partial  g(x,y)}{\partial x}\Biggr\rvert_{\overline{x},\overline{y}} & \frac{\partial  g(x,y)}{\partial y}\Biggr\rvert_{\overline{x},\overline{y}}
 \end{bmatrix} 
 \end{align} 
```
##
which for the particular case of the Lotka-Volterra is 


```math
\begin{align}
 J=\begin{bmatrix} 
 M_{11} & M_{12} \\ 
 M_{21} & M_{22}
 \end{bmatrix}_{\overline{x},\overline{y}} = \begin{bmatrix} 
 k_1 - k_2 \cdot \overline{y}  &  - k_2 \cdot \overline{x}   \\ 
k_2  \cdot \overline{y}  & k_2 \cdot \overline{x}  - k_3 
 \end{bmatrix}
 \end{align} 
```
##
Next, to investigate the stability, we check solutions in the form of small perturbations as follows:

```math
\begin{eqnarray}
(x,y) = (X_0,Y_0) e^{\lambda t}  
\end{eqnarray}
```
Here, $\lambda$ is the growth rate of the perturbations, also refered as eigenvalue. Each steady state will behave differently in terms of the dynamcis of the perturbations. Therefore, each steady state will have an associated eigenvalue. To find the eigen values, we solve the characteristic polynomial $det[J-\lambda I]=0$. 
##
```math
\begin{eqnarray}
Det \left(\begin{array}{cc}M_{11}-\lambda & M_{12} \\M_{21}& M_{22}-\lambda \end{array}\right) =0 
\end{eqnarray}
```
##
which gives us the corresponding equation:
```math
\begin{eqnarray}
\lambda^{2} -\lambda Tr(M) + Det(M)=0
\end{eqnarray}
```
##
where:
```math
\begin{eqnarray}
Tr(M)= M_{11}+M_{22} \\
Det(M)= M_{11}M_{22}-M_{12}M_{21} 
\end{eqnarray}
```

"

# ╔═╡ 6c96da07-b5ea-4096-a14c-5cd8f0f47c04
md"##
for the lotka-volterra case:

```math
\begin{eqnarray}
Tr(M)= k_{1} + k_2 (\overline{x}-\overline{y}) - k_3  \\
Det(M)= (k_1- k_2 \cdot \overline{y})(k_2 \cdot \overline{x} - k_3) - (k_2 \cdot\overline{y})(-k_2 \cdot \overline{x})  )
\end{eqnarray}
```
##
calculating 

```math
\begin{eqnarray}
Tr(M)= k_{1} + k_2 (\overline{x}-\overline{y}) - k_3  \\
Det(M)= - k_1 \cdot k_3 - k_2^2 \cdot \overline{y} \cdot \overline{x} + k_2  \cdot k_3 \cdot \overline{y} + k_1 \cdot k_2 \cdot \overline{x}+ k_2^2 \cdot\overline{y} \cdot \overline{x} 
\end{eqnarray}
```
##
and 

```math
\begin{eqnarray}
Tr(M)= k_{1} + k_2 (\overline{x}-\overline{y}) - k_3  \\
Det(M)= k_2  \cdot k_3 \cdot \overline{y} + k_1 \cdot k_2 \cdot \overline{x} - k_1 \cdot k_3 
\end{eqnarray}
```
##
so the chracteristic equation becomes:
```math
\begin{eqnarray}
\lambda^{2} -\lambda (k_{1} + k_2 (\overline{x}-\overline{y}) - k_3) + k_2  \cdot k_3 \cdot \overline{y} + k_1 \cdot k_2 \cdot \overline{x} - k_1 \cdot k_3=0
\end{eqnarray}
```
##
So, the polynomium for the fixed point $\overline{x},\overline{y}=[0,0]$ is 

```math
\begin{eqnarray}
\lambda^{2} +\lambda (k_3 - k_{1})  - k_1 \cdot k_3=0
\end{eqnarray}
```


"

# ╔═╡ 532acbb6-e504-4deb-88d5-e001a476af15
md"

```math
\begin{eqnarray}
\lambda &=& \frac{-(k_3 - k_{1})\pm \sqrt{(k_3 - k_{1})^2 + 4 \cdot k_1 \cdot k_3}}{2} \\
\lambda &=& \frac{-k_3 + k_{1}\pm \sqrt{k_3^2 + k_{1}^2 +2 \cdot k_1 \cdot k_3}}{2} \\ 
\lambda &=& \frac{-k_3 + k_{1}\pm \sqrt{(k_3 + k_{1})^2}}{2}  \\
\lambda &=& \frac{-k_3 + k_{1}\pm (k_3 + k_{1})}{2}  \\
\end{eqnarray}
```
so the two solutions are
```math
\begin{eqnarray}
\lambda_1 &=&  \frac{-k_3 + k_{1} + k_3 + k_{1}}{2} = k_{1} \\
\lambda_2 &=&  \frac{-k_3 + k_{1} - k_3 - k_{1}}{2} = -k_{3} \\
\end{eqnarray}
```


"

# ╔═╡ 906a0931-e86f-48f3-be11-eb692639e8cc
md" ##
Again, since $\lambda$ is the exponent that sets the dynamcis of the perturbations, depending on its value, the steady state is stable or unstable. 

since $k_1$ and $k_3$ are allways positive, we have one positive eigenvalue and one negative eigenvalue. 

For our Locka Volterra case, we can evaluate first the eigenvalues for the first steady state. It means that perturbations in one variable grow while perturbations in the other variable decay.  


"

# ╔═╡ c374e1bd-ec3d-4cf7-aff1-072d6ba60b27
function quadratic(a, b, c)
          discr = b^2 - 4*a*c
          discr >= 0 ?   ( (-b + sqrt(discr))/(2a), (-b - sqrt(discr))/(2a) ) : error("Only complex roots")
        end

# ╔═╡ 2b91a06c-3803-4877-ac9a-1669fbe58d30
begin
	k1_slide = @bind k1 html"<input type=range min=1 max=5 step=.1>"
	k2_slide = @bind k2 html"<input type=range min=1 max=5 step=.1>"
	k3_slide = @bind k3 html"<input type=range min=1 max=5 step=.1>"
	md"""
	**Set the values of the kinetic constants**
	
	value of k1: $(k1_slide)
	value of k2: $(k2_slide)
	value of k3: $(k3_slide)
	
	"""
end

# ╔═╡ e8ca5682-cce0-4b2c-ba18-47f2e38192c7
begin
	a= 1
	b= k3 - k1 
	c= - k1 * k3
	quadratic(a,b,c)
end

# ╔═╡ 17e34ce6-a1fa-4193-9201-3e61a188b48f
md"  
##
The stability of this fixed point [0,0] is of importance. If it both ewigenvalues are negative, the point will be stable, and non-zero populations might be attracted towards it, and as such the dynamics of the system might lead towards the extinction of both species for many cases of initial population levels.

##
However, as the steady state at the origin is unstable in one of the variables, we find that the extinction of both species is difficult in the model. In fact, in teh absence of foxes and rabits, a small increase in the foxes will lead to extintion (no food), while a small increase in the amount of rabbits will read to exponential increase (the unstable branch). 

These type of points are called a saddle node . 

##
For the other solution $[\overline{x},\overline{y}]=[\frac{k_3}{k_2},\frac{k_1}{k_2}]$

so the chracteristic equation becomes:
```math
\begin{eqnarray}
\lambda^{2} -\lambda (k_{1} + k_2 (\frac{k_3}{k_2}-\frac{k_1}{k_2}) - k_3) + k_2  \cdot k_3 \cdot \frac{k_1}{k_2} + k_1 \cdot k_2 \cdot \frac{k_3}{k_2} - k_1 \cdot k_3=0
\end{eqnarray}
```
##
```math
\begin{eqnarray}
\lambda^{2}  + k_3 \cdot k_1 =0
\end{eqnarray}
```

so, solving 

```math
\begin{eqnarray}
\lambda =  \pm \sqrt{- k_3 \cdot k_1} 
\end{eqnarray}
```

so, the two eigenvalues are:

```math
\begin{eqnarray}
\lambda_1 = + i \cdot k_3 \cdot k_1 \\
\lambda_2 = - i \cdot k_3 \cdot k_1
\end{eqnarray}
```

"

# ╔═╡ 87df7c88-7e16-4c50-bd80-df5bfea26ee8
begin
	
	aa=1
	bb= 0
	cc=- k1  + k2 *( k1 * k3)
	quadratic(aa,bb,cc)
end

# ╔═╡ 9433f4d1-3abf-4dea-8107-1070ee5feb2e
md"##
The two values are purely imaginary so we cannot say much about the stability. A small perturbation will not experience repulsion or atraction towards this steady state. There is no stable state (no atractor), and trajectories circulate about the fixed point in a stable orbit. This is called a _center_. 

The solutions travel periodically around the level sets in the counterclockwise direction
##
To test this, we solve numerically the system 

We assume as initial conditions:

```math
\begin{align}       
            x (0) &= 1 \tag{7} \\ 
            y (0) &= 1   \tag{8}   
\end{align}            
```
       
"

# ╔═╡ 2b9e43fd-d00d-40f1-ac98-07d48c53d861
md" ##
Similarly to what we did in the previous case, we would try to see the fixed points graphically. To do that in two dimensional systems, we find the functions where $\dot{x} = 0$ and $\dot{y} = 0$. These lines will represent the boundaries  between increase and decrease in $x$ and $y$. 
##
These curves are called the  nullclines. The method of nullclines is a technique for determining the global behavior of solutions of competing species models. This method provides an effective means of finding trapping regions for some differential equations. In a competition model, if a species population x is above a certain level, the fact of limited resources will cause x to decrease. 
##
Let's illustrate this again with the Lotka-Volterra. The functions that satisfy that the defivatives of $x$ and $y$ are zero are:

```math
\begin{align}       
            k_1 \cdot \overline{x} - k_2 \cdot \overline{x} \cdot \overline{y}  \tag{5} &= 0\\ 
            k_2 \cdot \overline{x} \cdot \overline{y} - k_3 \cdot \overline{y}  \tag{6} &= 0
            \end{align} 
```
##
In this particuular case, the lines are very simple, just constant values. 

```math
\begin{align}       
            \overline{x} &= \frac{k_3}{k_2}\tag{5} \\ 
            \overline{y} &= \frac{k_1}{k_2} \tag{6}   
            \end{align}    
```

"

# ╔═╡ 3349c942-15a8-4b1e-8b4a-7f5154f48b12
lv! = @ode_def LotkaVolterra begin
  dx = k1*x - k2*x*y
  dy =  k2*x*y - k3*y 
    end k1 k2 k3

# ╔═╡ c3828c90-0559-4686-9f56-41b5b6d48176
begin
	x₀=1
	y₀=1
	t₀=0.0
	final_time=10.0;
	prob = ODEProblem(lv!,[x₀,y₀],(t₀,final_time),(k1,k2,k3))
	sol = solve(prob)
	plot(sol,ylims = (0, 5))

	title!("Lotka-Volterra ")
	xlabel!("time [a.u.]")
    ylabel!("Amplitude [a.u.]")
	
end

# ╔═╡ ff0c4a06-de7b-4cf2-b920-cd84ac9927ea
[u[1] for (u,t) in tuples(sol)]


# ╔═╡ f8238a6e-1e5e-4629-ac20-2c9cb964c53e
tuples(sol)

# ╔═╡ df81eb5c-16ef-4bf6-9ad0-2cc899c44cb6
begin
	vline([k3/k2],ylims = (0, 5),xlims = (0, 10));
	hline!([k1/k2],ylims = (0, 5),xlims = (0, 10));
	title!("Null-Clines of the Lotka Volterra ")
	xlabel!("x [a.u.]")
    ylabel!("y [a.u.]")
	plot!([u[1] for (u,t) in tuples(sol)],[u[2] for (u,t) in tuples(sol)],ylims = (0, 15))

prob2 = ODEProblem(lv!,[x₀*2,y₀*2],(0.0,10.0),(k1,k2,k3))
	sol2 = solve(prob2)
	plot!([u[1] for (u,t) in tuples(sol2)],[u[2] for (u,t) in tuples(sol2)],ylims = (0, 15))
	
end

# ╔═╡ a5b38e90-cdbe-442f-a078-dd8598a0a4c2


md"
##
More concretely, if $Re(\lambda) < 0$, the perturbation decays in time and the steady state ($\overline{x},\overline{y}$) is stable. 

On the contrary, when $Re(\lambda) > 0$, the perturbation grows exponentially and the steady sate is unstable. 
##
More concretely, the steady state is stable if the following conditions are fulfilled:
```math
\begin{eqnarray}
Tr(M) < 0 \\
Det(M) >0
\end{eqnarray}
```
##
We can write the eigenvalue expression separating real and imaginary part:
```math
\begin{eqnarray}
\lambda=\mu \pm i \omega  
\end{eqnarray}
```
##
where

```math
\begin{eqnarray}
\mu=\frac{1}{2} Tr(M)\\
\omega=\sqrt{-\frac{1}{4} Tr(M)^2 + Det(M)}
\end{eqnarray}
```
##
The Hopf bifurcation takes place when $Det(M) > (1 / 4) Tr(M)^2 $ and $Tr(M) > 0$. In this case the eigenvalue has nonzero imaginary part and the solution of the system is oscillatory. In the Hopf threshold ($M_{11}=-M_{22}$) the complex part of the eigenvalue becomes:

```math
\begin{eqnarray}
\omega^2= \omega_{c}^{2}=-M_{11}^{2}-M_{12}M_{21}>0 \\
M_{12}M_{21}>M_{11}^{2}  (>0) 
\end{eqnarray}
```
##
One of the values must be positive, and the other negative. We choose $M_{11}>0$ $\longrightarrow$ $M_{22}<0$ and $M_{12}>0$ $\longrightarrow$ $M_{21}<0$. This way, we can write Eq. \ref{lineal1} and  Eq. \ref{lineal2} as follows:

```math
\begin{eqnarray}
\frac{\partial x}{\partial t} = M_{11} x - |M_{12}| y + ... \\
\frac{\partial y}{\partial t} = M_{21} x - |M_{22}| y + ... 
\end{eqnarray}
```
"

# ╔═╡ 3118e37d-f7bd-488e-ab3a-74e0194d3108
md"
## Stability and Eignevalues

Eigenvalues can be used to determine if a fixed point (also known as an equilibrium point) is stable or unstable. 

The eigenvalues of a system linearized around a fixed point can determine the stability behavior of a system around the fixed point. 

The particular stability behavior depends upon the existence of real and imaginary components of the eigenvalues, along with the signs of the real components and the distinctness of their values. 

We will examine each of the possible cases below.
##
### Complex Eigenvalues: 
-  If the real part is positive, the system is unstable and behaves as an unstable oscillator. This can be visualized as a vector tracing a spiral away from the fixed point.
- If the real part is zero, the system behaves as an undamped oscillator.
- If the real part is negative, then the system is stable and behaves as a damped oscillator. 
##
### Real Eigenvalues:
-  If equal to zero, the system will be unstable. This is just a trivial case of the complex eigenvalue that has a zero part.
- When all eigenvalues are real, positive, and distinct, the system is unstable. On a gradient field, a spot on the field with multiple vectors circularly surrounding and pointing out of the same spot (a node) signifies all positive eigenvalues. This is called a source node
- When all eigenvalues are real, negative, and distinct, the system is unstable. Graphically on a gradient field, there will be a node with vectors pointing toward the fixed point. This is called a sink node.
- If the set of eigenvalues for the system has both positive and negative eigenvalues, the fixed point is an unstable saddle point. A saddle point is a point where a series of minimum and maximum points converge at one area in a gradient field, without hitting the point. It is called a saddle point because in 3 dimensional surface plot the function looks like a saddle.

"

# ╔═╡ 48dbf14c-ab77-4e6a-9503-8dc53f5dfba8
Resource("https://eng.libretexts.org/@api/deki/files/18509/image-67.jpeg?revision=1")

# ╔═╡ cf72446a-a512-11ec-2b47-ef706c91c6a0
md" ## Cubic Autocatalator model

To study the behavior of nonlinear systems, a set of mathematical tools is  commonly used. Here, we will outline its main aspects from a simplified point of view, trying to introduce the reader to the mathematics inside the nonlinear pattern formation field. In addition we will try to illustrate the problem using a very simple autocatalitic model: the _Cubic Autocatalor Model_.


```math
\begin{align}
 2u + v &\overset{k_1=1}{\longrightarrow} 3u   \\
 u  &\overset{k_2=1}{\longrightarrow} 0 \\
 0 &\overset{k_3=\mu}{\longrightarrow} v
 \end{align}
```
  
##
The main equation which governs the aspects of pattern formation systems is the following nonlinear equations:

```math
\begin{eqnarray}
\frac{\partial u}{\partial t} = f(\mu, u, v) \\
\frac{\partial v}{\partial t} = g(\mu, u, v)
\end{eqnarray}
```
##
where $u$ and $v$ correspond to the concentration of activator and inhibitor.
Here, $f(\mu, u, v)$ and $g(\mu, u, v)$ are nonlinear functions which govern the temporal evolution of the variables. 
##
The first step is to calculate the fixed points of Eq. \ref{base1} and \ref{base2}, i.e., the values of the variables where the null-clines are in coincidence and equal to zero. This defines the steady state for the variables in a zero dimensional system.

```math
\begin{eqnarray}
f(\mu, u, v)=0  \\
g(\mu, u, v)=0
\end{eqnarray}
```
##
An example of the null-clines for the \textit{Cubic Autocatalor} Model can be seen in Fig. \ref{nullclines_cubic}. The equations for this specific model are:

```math
\begin{eqnarray}
\frac{\partial u}{\partial t} = u^2 v -u \\
\frac{\partial v}{\partial t} = \mu - u^2 v 
\end{eqnarray}
```

The steady state for this model is ($u_0,v_0$)= ($\mu, 1/\mu$)."

# ╔═╡ b67ed8c0-8ca7-4928-9ebc-98da513c432f
md"
##
The following step to study the evolution of the system is to linearize Eq. \ref{base1} and \ref{base2} around the steady state $(u_{0},v_{0})$. 

```math
\begin{eqnarray}
\frac{\partial u}{\partial t} = M_{11} u + M_{12} v + f_{2}(\mu, u, v) +   f_{3}(\mu, u, v) + ... \\
\frac{\partial v}{\partial t} = M_{21} u + M_{22} v + g_{2}(\mu, u, v) + g_{3}(\mu, u, v) + ... 
\end{eqnarray}
```
##
where $M_{ij}$ is calculated in the steady state ($u_{0},v_{0}$) as follows:
```math
\begin{eqnarray}
M_{11} = \frac{\partial  f(\mu, u, v)}{\partial u}\\
M_{12} = \frac{\partial  f(\mu, u, v)}{\partial v} \\
M_{21} = \frac{\partial  g(\mu, u, v)}{\partial u}\\
M_{22} = \frac{\partial  g(\mu, u, v)}{\partial v}
\end{eqnarray}
```

##
Where $M_{ij}$ are the components of the Jacobian matrix, evaluated at the steady state $(\overline{x},\overline{y})$. 

```math
\begin{align}
 J=\begin{bmatrix} 
 M_{11} & M_{12} \\ 
 M_{21} & M_{22}
 \end{bmatrix}_{\overline{x},\overline{y}}= \begin{bmatrix} 
\frac{\partial  f(x,y)}{\partial x}\Biggr\rvert_{\overline{x},\overline{y}} & \frac{\partial  f(x,y)}{\partial y}\Biggr\rvert_{\overline{x},\overline{y}} \\ 
\frac{\partial  g(x,y)}{\partial x}\Biggr\rvert_{\overline{x},\overline{y}} & \frac{\partial  g(x,y)}{\partial y}\Biggr\rvert_{\overline{x},\overline{y}}
 \end{bmatrix} 
 \end{align} 
```
##
which for the particular case of the Cubic autocatalator is 


```math
\begin{align}
 J=\begin{bmatrix} 
 M_{11} & M_{12} \\ 
 M_{21} & M_{22}
 \end{bmatrix}_{\overline{x},\overline{y}} = \begin{bmatrix} 
2 \overline{u}  \overline{v} - 1  &  \overline{u}^2   \\ 
-2  \overline{u}  \overline{v}  &  - \overline{u}^2
 \end{bmatrix}
 \end{align} 
```

##



To investigate the stability, we check solutions in the form of small perturbations as follows:
```math
\begin{eqnarray}
(u,v) = (U,V) e^{\lambda t}  
\end{eqnarray}
```
##
Here, $\lambda$ is the growth rate of the perturbations. The next step is to solve the eigenvalue problem, resulting of the introduction of Eq. \ref{solucion1} in the linearized system:
```math
\begin{eqnarray}
Det \left(\begin{array}{cc}M_{11}-\lambda & M_{12} \\M_{21}& M_{22}-\lambda \end{array}\right) =0 
\end{eqnarray}
```
##
and the corresponding equation:
```math
\begin{eqnarray}
\lambda^{2} -\lambda Tr(M) + Det(M)=0
\end{eqnarray}
```
##
where:
```math
\begin{eqnarray}
Tr(M)= M_{11}+M_{22} \\
Det(M)= M_{11}M_{22}-M_{12}M_{21} 
\end{eqnarray}
```
##
for this particular case

```math
\begin{eqnarray}
Tr(M)= 2 \overline{u}  \overline{v} - 1 - \overline{u}^2  \\
Det(M)= - \overline{u}^2 (2 \overline{u}  \overline{v} - 1) + 2   \overline{v} \overline{u}^3  = \overline{u}^2 
\end{eqnarray}
```
##
and the corresponding equation:
```math
\begin{eqnarray}
\lambda^{2} -\lambda (2 \overline{u}  \overline{v} - 1 - \overline{u}^2) +  \overline{u}^2=0
\end{eqnarray}


```
"




# ╔═╡ 05fe1502-dbac-4e9a-9944-7e5dcb090ae4
md"
##
We can sustitute now the value of the steady state

```math
\begin{eqnarray}
\lambda^{2} -\lambda (2 \frac{\mu}{\mu} - 1 - \mu^2) + \mu^2=0
\end{eqnarray}
```
##
so 


```math
\begin{eqnarray}
\lambda^{2} + \lambda (\mu^2 -1) + \mu^2=0
\end{eqnarray}
```

"

# ╔═╡ 8673be1a-122a-44e7-a9c7-45d12afb466b
md" ##
if $Re(\lambda) < 0$, the perturbation decays in time and the steady state ($\overline{x},\overline{y}$) is stable. 

On the contrary, when $Re(\lambda) > 0$, the perturbation grows exponentially and the steady sate is unstable. 

So, the steady state is stable if the following conditions are fulfilled:
```math
\begin{eqnarray}
Tr(M) < 0 \\
Det(M) >0
\end{eqnarray}
```
##


In this case, since $\mu$ is a reaction rate, it is allways positive, 

```math
\begin{eqnarray}
Det(M) = \mu^2 > 0
\end{eqnarray}
```

##
On the other hand, 

```math
\begin{eqnarray}
Tr(M) = 1 - \mu^2 < 0 \\ 
Tr(M) = \mu^2  > 1 \\ 
\end{eqnarray}
```

##
The Tr(M) is negative if $\mu > 1$, so the system is stable for values of $\mu>1$ and inestable for values of $\mu<1$. 

At this particular point $\mu<=1$, the polynomial becomes 

```math
\begin{eqnarray}
\lambda^{2} + 1 = 0\\
\lambda^{2} = -1\\
\lambda_{1,2} = \pm \sqrt{-1} = \pm i\\
\end{eqnarray}
```

The eigenvalue is purely imaginary, so perturbations do not decay or grow, but the system oscillates. Son at $\mu=1$ we have a stable center. It is a Hopf bifurcation. 


"

# ╔═╡ c36cfb05-9d05-42f0-87eb-a898b6c66317
md" ## 
if we solve the quadratic

```math
\begin{eqnarray}
\lambda = \frac{- (\mu^2 -1) + \sqrt{(\mu^2 -1)^2 - 4\mu^2 }}{2}\\
\lambda = \frac{- (\mu^2 -1) - \sqrt{(\mu^2 -1)^2 - 4\mu^2 }}{2}
\end{eqnarray}
```
we obtain 

```math
\begin{eqnarray}
\lambda = \frac{1 - \mu^2  + \sqrt{(\mu^2 -1)^2 - 4\mu^2 }}{2}\\
\lambda = \frac{1 - \mu^2 - \sqrt{(\mu^2 -1)^2 - 4\mu^2 }}{2}
\end{eqnarray}
```

we study when the number inside the square root changes it sign:
```math
\begin{eqnarray}
(\mu^2 -1)^2 - 4\mu^2 =0\\
(\mu^2 -1)^2 = 4\mu^2\\
\mu^2 -1 = 2\mu\\
\mu^2 +2 \mu -1 = 0
\end{eqnarray}
```

we solve 

```math
\begin{eqnarray}
\mu = \frac{-2 \pm \sqrt{2^2+4}}{2}\\
\mu = \frac{-2 \pm \sqrt{8}}{2}\\
\mu = \frac{-2 \pm 2\sqrt{2}}{2}\\
\mu = -1 \pm \sqrt{2}\\
\end{eqnarray}
```
so, between $ -1 - \sqrt{2} $ and $-1 + \sqrt{2}$ the value of $\mu < 0 $ so the square root is imaginary. This means we can get oscillations. Therefore, we have the following cases,

```math
\begin{eqnarray}
\mu  \in (0, -1 + \sqrt{2}) &\rightarrow& imaginary\\
\mu  \in (-1 + \sqrt{2},\infty) &\rightarrow& real\\
\end{eqnarray}
```

so, based on the value of the Trace, stable oscillations occur $\mu  \in (-1 + \sqrt{2},1)$, below this value $\mu  \in (0, -1 + \sqrt{2})$ we have a unstable node, if $\mu  \in (-1 + \sqrt{2},\infty)$ we have an stable spiral.

"

# ╔═╡ de338095-9ae6-4baa-bb2b-6a4b17f53e06
cubic! = @ode_def CubicAutocatalator begin
  dx = x^2*y - x
  dy =  µ - x^2*y 
end µ

# ╔═╡ 268c3afc-d66f-4419-8cc7-e0bf8ff000a0
begin
	µ_slide = @bind µ html"<input type=range min=0 max=2 step=.01>"
	md"""
	**Set the values of the kinetic constants**
	
	value of µ: $(µ_slide)
	
	"""
end

# ╔═╡ c8b683ca-9620-428d-98c4-2e5b18ec1720
begin
	aaa=1
	bbb= µ^2-1
	ccc=µ^2
	quadratic(aaa,bbb,ccc)
end

# ╔═╡ 2e76d7b1-b293-410c-9ab3-48bed3c2a388
prob3 = ODEProblem(cubic!,[x₀,y₀],(0.0,500.0),µ)

# ╔═╡ 7cb2a5e9-a1a3-438e-a44d-252b7009638d
sol3 = solve(prob3);

# ╔═╡ 1c798e63-9a9d-4e27-91a3-a2e0e1e89b75
begin
	plot(sol3,ylims = (0, 10))
	title!("Solution for for Cubic autocatalor µ = $µ ")
end

# ╔═╡ 88299113-dc0c-4956-9db8-783c763d957b
begin
	plot([u[1] for (u,t) in tuples(sol3)],[u[2] for (u,t) in tuples(sol3)],ylims = (0, 4),xlims = (0, 4))
	title!("Phase plane for Cubic autocatalor for µ = $µ ")
end

# ╔═╡ ec119596-0b9e-467f-b05b-abf77d4d0a62
begin
	vline([k3/k2],ylims = (0, 4),xlims = (0, 4));
	hline!([k1/k2],ylims = (0, 4),xlims = (0,4));
	title!("Null-Clines of the Cubic autocatalator model ")
	xlabel!("x [a.u.]")
    ylabel!("y [a.u.]")
	plot!([u[1] for (u,t) in tuples(sol)],[u[2] for (u,t) in tuples(sol)],)


	plot!([u[1] for (u,t) in tuples(sol2)],[u[2] for (u,t) in tuples(sol2)])
	
end

# ╔═╡ d533c313-2dcd-404d-8740-65294a096954
md"##

"

# ╔═╡ 67091261-3b6c-4a94-9a70-86519a1eed76
md"

### Stability of Spatial Systems

The next step is to to consider the spatial dimensions of the system in Eq. \ref{base1} and Eq. \ref{base2}.

```math
\begin{eqnarray}
\frac{\partial u}{\partial t} = f(\mu, u, v)  + D_u \frac{\partial^{2} u}{\partial \vec{r}^{2}}\\
\frac{\partial v}{\partial t} = g(\mu, u, v) + D_v \frac{\partial^{2} v}{\partial \vec{r}^{2}}
\end{eqnarray}
```
##
Here, $D_u$ and $D_v$ are the diffusion coefficients of activator and inhibitor and $ \vec{r}$ is the spatial coordinate. We will scale the diffusion coefficients in a way that we can reduce to a variable which only takes account of the ratio between the diffusion coefficients: $d=D_{v}/D_{u}$. 
##
Now we have to check solutions with the spatial part: 
```math
\begin{eqnarray}
(u,v) = (U,V) e^{\lambda t + i \vec{k}\vec{r}}  
\end{eqnarray}
```
##
The Jacobian matrix $M$ of the system is:
```math
\begin{eqnarray}
M=\left(\begin{array}{cc}M_{11} - k^{2} & M_{12} \\M_{21}& M_{22} - d k^{2} \end{array}\right) 
\end{eqnarray}
```
##
If we solve the eigenvalue problem ($Det (M-\lambda I)=0$), as in the previous case without spatial dimensions (unstable steady state) some other conditions are required to get positive eigenvalues. The equation is:
```math
\begin{eqnarray}
\lambda^2+\lambda(k^2(1+d)-Tr(M))+Det(M)=0  
\end{eqnarray}
```
##
The solution is in the form:
```math
\begin{eqnarray}
\lambda=\frac{1}{2}(-k^{2}(1+d)+Tr (M) \pm 
 \sqrt{(k^{2}(1+d)-Tr (M))^{2}-4 B} 
 \end{eqnarray}
```
##
 where

```math 
 \begin{eqnarray}
 d &=& \frac{D_{v}}{D_{u}} \\
 Tr (M) &=& M_{11} + M_{22} \\
 Det(M) &=& M_{11}  M_{22} - M_{21}  M_{12} \\
 B &=& d k^{4} - d k^{2} M_{11} - k^{2} M_{22} + Det (M) 
\end{eqnarray}
```
##
So, the system will be unstable if one of the following conditions is fulfilled: 
```math
\begin{eqnarray}
k^2(1+d)-Tr(M) < 0 \\
 Det(M) < 0  
\end{eqnarray}
```
##
In addition, if the eigenvalues are positive and real, which means that $k^2(1+d)-Tr(M))^{2}> 4 Det(M)$, the system will grow exponentially (Turing bifurcation) The system, now with spatial dimensions, develops steady periodic patterns. There is a window of unstable wavelengths which the system may exhibit ($k$ with Re[$\lambda_{1,2}] > 0$). 
##
But there is one with maximum growth rate, which can be easily calculated by solving Eq. \ref{eigen1}:
```math
\begin{eqnarray}
\frac{\partial \lambda}{\partial k}=0  
\end{eqnarray}
```
##

Fig. Re dispersion is a plot of the real part of one of the the eigenvalues $\lambda_{1}$ which has a region of positive growth for some wavenumbers in the  Lengyel-Epstein model (see Sec sec: LE model ). This means that a perturbation with a wavenumber with positive eigenvalue will grow exponentially in time. The other eigenvalue is negative, so it does not influence the behavior of the system. In addition Fig. Im_dispersion  shows the imaginary part of both eigenvalues. Positive imaginary values of the growth rate are outside of the regime of positive real values in Fig. Re_dispersion , so the periodic pattern (with wavenumber $k$) is steady in time."

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
DifferentialEquations = "0c46a032-eb83-5123-abaf-570d42b7fbaa"
ParameterizedFunctions = "65888b18-ceab-5e60-b2b9-181511a3b968"
Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
DifferentialEquations = "~7.7.0"
ParameterizedFunctions = "~5.15.0"
Plots = "~1.38.12"
PlutoUI = "~0.7.51"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.11.0"
manifest_format = "2.0"
project_hash = "2bc42928b7e89ed26b742e8be4141773dd966f31"

[[deps.ADTypes]]
git-tree-sha1 = "f5c25e8a5b29b5e941b7408bc8cc79fea4d9ef9a"
uuid = "47edcb42-4c32-4615-8424-f2b9edc5f35b"
version = "0.1.6"

[[deps.AbstractAlgebra]]
deps = ["GroupsCore", "InteractiveUtils", "LinearAlgebra", "MacroTools", "Preferences", "Random", "RandomExtensions", "SparseArrays", "Test"]
git-tree-sha1 = "d7832de8cf7af26abac741f10372080ac6cb73df"
uuid = "c3fe647b-3220-5bb0-a1ea-a7954cac585d"
version = "0.34.7"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "6e1d2a35f2f90a4bc7c2ed98079b2ba09c35b83a"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.3.2"

[[deps.AbstractTrees]]
git-tree-sha1 = "2d9c9a55f9c93e8887ad391fbae72f8ef55e1177"
uuid = "1520ce14-60c1-5f80-bbc7-55ef81b5835c"
version = "0.4.5"

[[deps.Adapt]]
deps = ["LinearAlgebra", "Requires"]
git-tree-sha1 = "cde29ddf7e5726c9fb511f340244ea3481267608"
uuid = "79e6a3ab-5dfb-504d-930d-738a2a938a0e"
version = "3.7.2"
weakdeps = ["StaticArrays"]

    [deps.Adapt.extensions]
    AdaptStaticArraysExt = "StaticArrays"

[[deps.AliasTables]]
deps = ["PtrArrays", "Random"]
git-tree-sha1 = "9876e1e164b144ca45e9e3198d0b689cadfed9ff"
uuid = "66dad0bd-aa9a-41b7-9441-69ab47430ed8"
version = "1.1.3"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.2"

[[deps.ArnoldiMethod]]
deps = ["LinearAlgebra", "Random", "StaticArrays"]
git-tree-sha1 = "d57bd3762d308bded22c3b82d033bff85f6195c6"
uuid = "ec485272-7323-5ecc-a04f-4719b315124d"
version = "0.4.0"

[[deps.ArrayInterface]]
deps = ["Adapt", "LinearAlgebra", "Requires", "SparseArrays", "SuiteSparse"]
git-tree-sha1 = "c5aeb516a84459e0318a02507d2261edad97eb75"
uuid = "4fba245c-0d91-5ea0-9b3e-6abc04ee57a9"
version = "7.7.1"

    [deps.ArrayInterface.extensions]
    ArrayInterfaceBandedMatricesExt = "BandedMatrices"
    ArrayInterfaceBlockBandedMatricesExt = "BlockBandedMatrices"
    ArrayInterfaceCUDAExt = "CUDA"
    ArrayInterfaceGPUArraysCoreExt = "GPUArraysCore"
    ArrayInterfaceStaticArraysCoreExt = "StaticArraysCore"
    ArrayInterfaceTrackerExt = "Tracker"

    [deps.ArrayInterface.weakdeps]
    BandedMatrices = "aae01518-5342-5314-be14-df237901396f"
    BlockBandedMatrices = "ffab5731-97b5-5995-9138-79e8c1846df0"
    CUDA = "052768ef-5323-5732-b1bb-66c8b64840ba"
    GPUArraysCore = "46192b85-c4d5-4398-a991-12ede77f4527"
    StaticArraysCore = "1e83bf80-4336-4d27-bf5d-d5a4f845583c"
    Tracker = "9f7883ad-71c0-57eb-9f7f-b5c9e6d3789c"

[[deps.ArrayLayouts]]
deps = ["FillArrays", "LinearAlgebra"]
git-tree-sha1 = "0dd7edaff278e346eb0ca07a7e75c9438408a3ce"
uuid = "4c555306-a7a7-4459-81d9-ec55ddd5c99a"
version = "1.10.3"
weakdeps = ["SparseArrays"]

    [deps.ArrayLayouts.extensions]
    ArrayLayoutsSparseArraysExt = "SparseArrays"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"
version = "1.11.0"

[[deps.BandedMatrices]]
deps = ["ArrayLayouts", "FillArrays", "LinearAlgebra", "PrecompileTools"]
git-tree-sha1 = "0b816941273b5b162be122a6c94d706e3b3125ca"
uuid = "aae01518-5342-5314-be14-df237901396f"
version = "0.17.38"
weakdeps = ["SparseArrays"]

    [deps.BandedMatrices.extensions]
    BandedMatricesSparseArraysExt = "SparseArrays"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"
version = "1.11.0"

[[deps.Bijections]]
git-tree-sha1 = "d8b0439d2be438a5f2cd68ec158fe08a7b2595b7"
uuid = "e2ed5e7c-b2de-5872-ae92-c73ca462fb04"
version = "0.1.9"

[[deps.BitFlags]]
git-tree-sha1 = "0691e34b3bb8be9307330f88d1a3c3f25466c24d"
uuid = "d1d4a3ce-64b1-5f1a-9ba4-7e7e69966f35"
version = "0.1.9"

[[deps.BitTwiddlingConvenienceFunctions]]
deps = ["Static"]
git-tree-sha1 = "f21cfd4950cb9f0587d5067e69405ad2acd27b87"
uuid = "62783981-4cbd-42fc-bca8-16325de8dc4b"
version = "0.1.6"

[[deps.BoundaryValueDiffEq]]
deps = ["BandedMatrices", "DiffEqBase", "FiniteDiff", "ForwardDiff", "LinearAlgebra", "NLsolve", "Reexport", "SciMLBase", "SparseArrays"]
git-tree-sha1 = "ed8e837bfb3d1e3157022c9636ec1c722b637318"
uuid = "764a87c0-6b3e-53db-9096-fe964310641d"
version = "2.11.0"

[[deps.Bzip2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "9e2a6b69137e6969bab0152632dcb3bc108c8bdd"
uuid = "6e34b625-4abd-537c-b88f-471c36dfa7a0"
version = "1.0.8+1"

[[deps.CEnum]]
git-tree-sha1 = "389ad5c84de1ae7cf0e28e381131c98ea87d54fc"
uuid = "fa961155-64e5-5f13-b03f-caf6b980ea82"
version = "0.5.0"

[[deps.CPUSummary]]
deps = ["CpuId", "IfElse", "PrecompileTools", "Static"]
git-tree-sha1 = "5a97e67919535d6841172016c9530fd69494e5ec"
uuid = "2a0fbf3d-bb9c-48f3-b0a9-814d99fd7ab9"
version = "0.2.6"

[[deps.CSTParser]]
deps = ["Tokenize"]
git-tree-sha1 = "0157e592151e39fa570645e2b2debcdfb8a0f112"
uuid = "00ebfdb7-1f24-5e51-bd34-a7502290713f"
version = "3.4.3"

[[deps.Cairo_jll]]
deps = ["Artifacts", "Bzip2_jll", "CompilerSupportLibraries_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "JLLWrappers", "LZO_jll", "Libdl", "Pixman_jll", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "009060c9a6168704143100f36ab08f06c2af4642"
uuid = "83423d85-b0ee-5818-9007-b63ccbeb887a"
version = "1.18.2+1"

[[deps.ChainRulesCore]]
deps = ["Compat", "LinearAlgebra"]
git-tree-sha1 = "3e4b134270b372f2ed4d4d0e936aabaefc1802bc"
uuid = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
version = "1.25.0"
weakdeps = ["SparseArrays"]

    [deps.ChainRulesCore.extensions]
    ChainRulesCoreSparseArraysExt = "SparseArrays"

[[deps.CloseOpenIntervals]]
deps = ["Static", "StaticArrayInterface"]
git-tree-sha1 = "05ba0d07cd4fd8b7a39541e31a7b0254704ea581"
uuid = "fb6a15b2-703c-40df-9091-08a04967cfa9"
version = "0.1.13"

[[deps.CodecZlib]]
deps = ["TranscodingStreams", "Zlib_jll"]
git-tree-sha1 = "bce6804e5e6044c6daab27bb533d1295e4a2e759"
uuid = "944b1d66-785c-5afd-91f1-9de20f533193"
version = "0.7.6"

[[deps.ColorSchemes]]
deps = ["ColorTypes", "ColorVectorSpace", "Colors", "FixedPointNumbers", "PrecompileTools", "Random"]
git-tree-sha1 = "b5278586822443594ff615963b0c09755771b3e0"
uuid = "35d6a980-a343-548e-a6ea-1d62b119f2f4"
version = "3.26.0"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "b10d0b65641d57b8b4d5e234446582de5047050d"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.5"

[[deps.ColorVectorSpace]]
deps = ["ColorTypes", "FixedPointNumbers", "LinearAlgebra", "Requires", "Statistics", "TensorCore"]
git-tree-sha1 = "a1f44953f2382ebb937d60dafbe2deea4bd23249"
uuid = "c3611d14-8923-5661-9e6a-0046d554d3a4"
version = "0.10.0"
weakdeps = ["SpecialFunctions"]

    [deps.ColorVectorSpace.extensions]
    SpecialFunctionsExt = "SpecialFunctions"

[[deps.Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "362a287c3aa50601b0bc359053d5c2468f0e7ce0"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.12.11"

[[deps.Combinatorics]]
git-tree-sha1 = "08c8b6831dc00bfea825826be0bc8336fc369860"
uuid = "861a8166-3701-5b0c-9a16-15d98fcdc6aa"
version = "1.0.2"

[[deps.CommonMark]]
deps = ["Crayons", "PrecompileTools"]
git-tree-sha1 = "3faae67b8899797592335832fccf4b3c80bb04fa"
uuid = "a80b9123-70ca-4bc0-993e-6e3bcb318db6"
version = "0.8.15"

[[deps.CommonSolve]]
git-tree-sha1 = "0eee5eb66b1cf62cd6ad1b460238e60e4b09400c"
uuid = "38540f10-b2f7-11e9-35d8-d573e4eb0ff2"
version = "0.2.4"

[[deps.CommonSubexpressions]]
deps = ["MacroTools"]
git-tree-sha1 = "cda2cfaebb4be89c9084adaca7dd7333369715c5"
uuid = "bbf7d656-a473-5ed7-a52c-81e309532950"
version = "0.3.1"

[[deps.Compat]]
deps = ["TOML", "UUIDs"]
git-tree-sha1 = "8ae8d32e09f0dcf42a36b90d4e17f5dd2e4c4215"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.16.0"
weakdeps = ["Dates", "LinearAlgebra"]

    [deps.Compat.extensions]
    CompatLinearAlgebraExt = "LinearAlgebra"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.1.1+0"

[[deps.CompositeTypes]]
git-tree-sha1 = "bce26c3dab336582805503bed209faab1c279768"
uuid = "b152e2b5-7a66-4b01-a709-34e65c35f657"
version = "0.1.4"

[[deps.ConcurrentUtilities]]
deps = ["Serialization", "Sockets"]
git-tree-sha1 = "ea32b83ca4fefa1768dc84e504cc0a94fb1ab8d1"
uuid = "f0e56b4a-5159-44fe-b623-3e5288b988bb"
version = "2.4.2"

[[deps.ConstructionBase]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "d8a9c0b6ac2d9081bf76324b39c78ca3ce4f0c98"
uuid = "187b0558-2788-49d3-abe0-74a17ed4e7c9"
version = "1.5.6"
weakdeps = ["IntervalSets", "StaticArrays"]

    [deps.ConstructionBase.extensions]
    ConstructionBaseIntervalSetsExt = "IntervalSets"
    ConstructionBaseStaticArraysExt = "StaticArrays"

[[deps.Contour]]
git-tree-sha1 = "439e35b0b36e2e5881738abc8857bd92ad6ff9a8"
uuid = "d38c429a-6771-53c6-b99e-75d170b6e991"
version = "0.6.3"

[[deps.CpuId]]
deps = ["Markdown"]
git-tree-sha1 = "fcbb72b032692610bfbdb15018ac16a36cf2e406"
uuid = "adafc99b-e345-5852-983c-f28acb93d879"
version = "0.3.1"

[[deps.Crayons]]
git-tree-sha1 = "249fe38abf76d48563e2f4556bebd215aa317e15"
uuid = "a8cc5b0e-0ffa-5ad4-8c14-923d3ee1735f"
version = "4.1.1"

[[deps.DataAPI]]
git-tree-sha1 = "abe83f3a2f1b857aac70ef8b269080af17764bbe"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.16.0"

[[deps.DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "1d0a14036acb104d9e89698bd408f63ab58cdc82"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.20"

[[deps.DataValueInterfaces]]
git-tree-sha1 = "bfc1187b79289637fa0ef6d4436ebdfe6905cbd6"
uuid = "e2d170a0-9d28-54be-80f0-106bbe20a464"
version = "1.0.0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"
version = "1.11.0"

[[deps.Dbus_jll]]
deps = ["Artifacts", "Expat_jll", "JLLWrappers", "Libdl"]
git-tree-sha1 = "fc173b380865f70627d7dd1190dc2fce6cc105af"
uuid = "ee1fde0b-3d02-5ea6-8484-8dfef6360eab"
version = "1.14.10+0"

[[deps.DelayDiffEq]]
deps = ["ArrayInterface", "DataStructures", "DiffEqBase", "LinearAlgebra", "Logging", "OrdinaryDiffEq", "Printf", "RecursiveArrayTools", "Reexport", "SciMLBase", "SimpleNonlinearSolve", "SimpleUnPack"]
git-tree-sha1 = "e40378efd2af7658d0a0579aa9e15b17137368f4"
uuid = "bcd4f6db-9728-5f36-b5f7-82caef46ccdb"
version = "5.44.0"

[[deps.DelimitedFiles]]
deps = ["Mmap"]
git-tree-sha1 = "9e2f36d3c96a820c678f2f1f1782582fcf685bae"
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"
version = "1.9.1"

[[deps.DiffEqBase]]
deps = ["ArrayInterface", "ChainRulesCore", "DataStructures", "DocStringExtensions", "EnumX", "FastBroadcast", "ForwardDiff", "FunctionWrappers", "FunctionWrappersWrappers", "LinearAlgebra", "Logging", "Markdown", "MuladdMacro", "Parameters", "PreallocationTools", "PrecompileTools", "Printf", "RecursiveArrayTools", "Reexport", "Requires", "SciMLBase", "SciMLOperators", "Setfield", "SparseArrays", "Static", "StaticArraysCore", "Statistics", "Tricks", "TruncatedStacktraces", "ZygoteRules"]
git-tree-sha1 = "0d9982e8dee851d519145857e79a17ee33ede154"
uuid = "2b5f629d-d688-5b77-993f-72d75c75574e"
version = "6.130.0"

    [deps.DiffEqBase.extensions]
    DiffEqBaseDistributionsExt = "Distributions"
    DiffEqBaseGeneralizedGeneratedExt = "GeneralizedGenerated"
    DiffEqBaseMPIExt = "MPI"
    DiffEqBaseMeasurementsExt = "Measurements"
    DiffEqBaseMonteCarloMeasurementsExt = "MonteCarloMeasurements"
    DiffEqBaseReverseDiffExt = "ReverseDiff"
    DiffEqBaseTrackerExt = "Tracker"
    DiffEqBaseUnitfulExt = "Unitful"
    DiffEqBaseZygoteExt = "Zygote"

    [deps.DiffEqBase.weakdeps]
    Distributions = "31c24e10-a181-5473-b8eb-7969acd0382f"
    GeneralizedGenerated = "6b9d7cbe-bcb9-11e9-073f-15a7a543e2eb"
    MPI = "da04e1cc-30fd-572f-bb4f-1f8673147195"
    Measurements = "eff96d63-e80a-5855-80a2-b1b0885c5ab7"
    MonteCarloMeasurements = "0987c9cc-fe09-11e8-30f0-b96dd679fdca"
    ReverseDiff = "37e2e3b7-166d-5795-8a7a-e32c996b4267"
    Tracker = "9f7883ad-71c0-57eb-9f7f-b5c9e6d3789c"
    Unitful = "1986cc42-f94f-5a68-af5c-568840ba703d"
    Zygote = "e88e6eb3-aa80-5325-afca-941959d7151f"

[[deps.DiffEqCallbacks]]
deps = ["DataStructures", "DiffEqBase", "ForwardDiff", "Functors", "LinearAlgebra", "Markdown", "NLsolve", "Parameters", "RecipesBase", "RecursiveArrayTools", "SciMLBase", "StaticArraysCore"]
git-tree-sha1 = "d0b94b3694d55e7eedeee918e7daee9e3b873399"
uuid = "459566f4-90b8-5000-8ac3-15dfb0a30def"
version = "2.35.0"
weakdeps = ["OrdinaryDiffEq", "Sundials"]

[[deps.DiffEqNoiseProcess]]
deps = ["DiffEqBase", "Distributions", "GPUArraysCore", "LinearAlgebra", "Markdown", "Optim", "PoissonRandom", "QuadGK", "Random", "Random123", "RandomNumbers", "RecipesBase", "RecursiveArrayTools", "ResettableStacks", "SciMLBase", "StaticArraysCore", "Statistics"]
git-tree-sha1 = "ab1e6515ce15f01316a9825b02729fefa51726bd"
uuid = "77a26b50-5914-5dd7-bc55-306e6241c503"
version = "5.23.0"

    [deps.DiffEqNoiseProcess.extensions]
    DiffEqNoiseProcessReverseDiffExt = "ReverseDiff"

    [deps.DiffEqNoiseProcess.weakdeps]
    ReverseDiff = "37e2e3b7-166d-5795-8a7a-e32c996b4267"

[[deps.DiffResults]]
deps = ["StaticArraysCore"]
git-tree-sha1 = "782dd5f4561f5d267313f23853baaaa4c52ea621"
uuid = "163ba53b-c6d8-5494-b064-1a9d43ac40c5"
version = "1.1.0"

[[deps.DiffRules]]
deps = ["IrrationalConstants", "LogExpFunctions", "NaNMath", "Random", "SpecialFunctions"]
git-tree-sha1 = "23163d55f885173722d1e4cf0f6110cdbaf7e272"
uuid = "b552c78f-8df3-52c6-915a-8e097449b14b"
version = "1.15.1"

[[deps.DifferentialEquations]]
deps = ["BoundaryValueDiffEq", "DelayDiffEq", "DiffEqBase", "DiffEqCallbacks", "DiffEqNoiseProcess", "JumpProcesses", "LinearAlgebra", "LinearSolve", "NonlinearSolve", "OrdinaryDiffEq", "Random", "RecursiveArrayTools", "Reexport", "SciMLBase", "SteadyStateDiffEq", "StochasticDiffEq", "Sundials"]
git-tree-sha1 = "ac145e3d718157c679fc4febf2fcef73ec77b067"
uuid = "0c46a032-eb83-5123-abaf-570d42b7fbaa"
version = "7.7.0"

[[deps.Distances]]
deps = ["LinearAlgebra", "Statistics", "StatsAPI"]
git-tree-sha1 = "66c4c81f259586e8f002eacebc177e1fb06363b0"
uuid = "b4f34e82-e78d-54a5-968a-f98e89d6e8f7"
version = "0.10.11"
weakdeps = ["ChainRulesCore", "SparseArrays"]

    [deps.Distances.extensions]
    DistancesChainRulesCoreExt = "ChainRulesCore"
    DistancesSparseArraysExt = "SparseArrays"

[[deps.Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"
version = "1.11.0"

[[deps.Distributions]]
deps = ["AliasTables", "FillArrays", "LinearAlgebra", "PDMats", "Printf", "QuadGK", "Random", "SpecialFunctions", "Statistics", "StatsAPI", "StatsBase", "StatsFuns"]
git-tree-sha1 = "d7477ecdafb813ddee2ae727afa94e9dcb5f3fb0"
uuid = "31c24e10-a181-5473-b8eb-7969acd0382f"
version = "0.25.112"

    [deps.Distributions.extensions]
    DistributionsChainRulesCoreExt = "ChainRulesCore"
    DistributionsDensityInterfaceExt = "DensityInterface"
    DistributionsTestExt = "Test"

    [deps.Distributions.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    DensityInterface = "b429d917-457f-4dbc-8f4c-0cc954292b1d"
    Test = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.DocStringExtensions]]
deps = ["LibGit2"]
git-tree-sha1 = "2fb1e02f2b635d0845df5d7c167fec4dd739b00d"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.9.3"

[[deps.DomainSets]]
deps = ["CompositeTypes", "IntervalSets", "LinearAlgebra", "Random", "StaticArrays", "Statistics"]
git-tree-sha1 = "51b4b84d33ec5e0955b55ff4b748b99ce2c3faa9"
uuid = "5b8099bc-c8ec-5219-889f-1d9e522a28bf"
version = "0.6.7"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.DynamicPolynomials]]
deps = ["Future", "LinearAlgebra", "MultivariatePolynomials", "MutableArithmetics", "Pkg", "Reexport", "Test"]
git-tree-sha1 = "30a1848c4f4fc35d1d4bbbd125650f6a11b5bc6c"
uuid = "7c1d4256-1411-5781-91ec-d7bc3513ac07"
version = "0.5.7"

[[deps.EnumX]]
git-tree-sha1 = "bdb1942cd4c45e3c678fd11569d5cccd80976237"
uuid = "4e289a0a-7415-4d19-859d-a7e5c4648b56"
version = "1.0.4"

[[deps.EpollShim_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "8e9441ee83492030ace98f9789a654a6d0b1f643"
uuid = "2702e6a9-849d-5ed8-8c21-79e8b8f9ee43"
version = "0.0.20230411+0"

[[deps.ExceptionUnwrapping]]
deps = ["Test"]
git-tree-sha1 = "dcb08a0d93ec0b1cdc4af184b26b591e9695423a"
uuid = "460bff9d-24e4-43bc-9d9f-a8973cb893f4"
version = "0.1.10"

[[deps.Expat_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1c6317308b9dc757616f0b5cb379db10494443a7"
uuid = "2e619515-83b5-522b-bb60-26c02a35a201"
version = "2.6.2+0"

[[deps.ExponentialUtilities]]
deps = ["Adapt", "ArrayInterface", "GPUArraysCore", "GenericSchur", "LinearAlgebra", "PrecompileTools", "Printf", "SparseArrays", "libblastrampoline_jll"]
git-tree-sha1 = "8e18940a5ba7f4ddb41fe2b79b6acaac50880a86"
uuid = "d4d017d3-3776-5f7e-afef-a10c40355c18"
version = "1.26.1"

[[deps.ExprTools]]
git-tree-sha1 = "27415f162e6028e81c72b82ef756bf321213b6ec"
uuid = "e2ba6199-217a-4e67-a87a-7c52f15ade04"
version = "0.1.10"

[[deps.FFMPEG]]
deps = ["FFMPEG_jll"]
git-tree-sha1 = "53ebe7511fa11d33bec688a9178fac4e49eeee00"
uuid = "c87230d0-a227-11e9-1b43-d7ebe4e7570a"
version = "0.4.2"

[[deps.FFMPEG_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "JLLWrappers", "LAME_jll", "Libdl", "Ogg_jll", "OpenSSL_jll", "Opus_jll", "PCRE2_jll", "Zlib_jll", "libaom_jll", "libass_jll", "libfdk_aac_jll", "libvorbis_jll", "x264_jll", "x265_jll"]
git-tree-sha1 = "466d45dc38e15794ec7d5d63ec03d776a9aff36e"
uuid = "b22a6f82-2f65-5046-a5b2-351ab43fb4e5"
version = "4.4.4+1"

[[deps.FastBroadcast]]
deps = ["ArrayInterface", "LinearAlgebra", "Polyester", "Static", "StaticArrayInterface", "StrideArraysCore"]
git-tree-sha1 = "a6e756a880fc419c8b41592010aebe6a5ce09136"
uuid = "7034ab61-46d4-4ed7-9d0f-46aef9175898"
version = "0.2.8"

[[deps.FastClosures]]
git-tree-sha1 = "acebe244d53ee1b461970f8910c235b259e772ef"
uuid = "9aa1b823-49e4-5ca5-8b0f-3971ec8bab6a"
version = "0.3.2"

[[deps.FastLapackInterface]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "c1293a93193f0ae94be7cf338d33e162c39d8788"
uuid = "29a986be-02c6-4525-aec4-84b980013641"
version = "1.2.9"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"
version = "1.11.0"

[[deps.FillArrays]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "6a70198746448456524cb442b8af316927ff3e1a"
uuid = "1a297f60-69ca-5386-bcde-b61e274b549b"
version = "1.13.0"
weakdeps = ["PDMats", "SparseArrays", "Statistics"]

    [deps.FillArrays.extensions]
    FillArraysPDMatsExt = "PDMats"
    FillArraysSparseArraysExt = "SparseArrays"
    FillArraysStatisticsExt = "Statistics"

[[deps.FiniteDiff]]
deps = ["ArrayInterface", "LinearAlgebra", "Requires", "Setfield", "SparseArrays"]
git-tree-sha1 = "2de436b72c3422940cbe1367611d137008af7ec3"
uuid = "6a86dc24-6348-571c-b903-95158fe2bd41"
version = "2.23.1"

    [deps.FiniteDiff.extensions]
    FiniteDiffBandedMatricesExt = "BandedMatrices"
    FiniteDiffBlockBandedMatricesExt = "BlockBandedMatrices"
    FiniteDiffStaticArraysExt = "StaticArrays"

    [deps.FiniteDiff.weakdeps]
    BandedMatrices = "aae01518-5342-5314-be14-df237901396f"
    BlockBandedMatrices = "ffab5731-97b5-5995-9138-79e8c1846df0"
    StaticArrays = "90137ffa-7385-5640-81b9-e52037218182"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "05882d6995ae5c12bb5f36dd2ed3f61c98cbb172"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.5"

[[deps.Fontconfig_jll]]
deps = ["Artifacts", "Bzip2_jll", "Expat_jll", "FreeType2_jll", "JLLWrappers", "Libdl", "Libuuid_jll", "Zlib_jll"]
git-tree-sha1 = "db16beca600632c95fc8aca29890d83788dd8b23"
uuid = "a3f928ae-7b40-5064-980b-68af3947d34b"
version = "2.13.96+0"

[[deps.Formatting]]
deps = ["Logging", "Printf"]
git-tree-sha1 = "fb409abab2caf118986fc597ba84b50cbaf00b87"
uuid = "59287772-0a20-5a39-b81b-1366585eb4c0"
version = "0.4.3"

[[deps.ForwardDiff]]
deps = ["CommonSubexpressions", "DiffResults", "DiffRules", "LinearAlgebra", "LogExpFunctions", "NaNMath", "Preferences", "Printf", "Random", "SpecialFunctions"]
git-tree-sha1 = "cf0fe81336da9fb90944683b8c41984b08793dad"
uuid = "f6369f11-7733-5829-9624-2563aa707210"
version = "0.10.36"
weakdeps = ["StaticArrays"]

    [deps.ForwardDiff.extensions]
    ForwardDiffStaticArraysExt = "StaticArrays"

[[deps.FreeType2_jll]]
deps = ["Artifacts", "Bzip2_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "5c1d8ae0efc6c2e7b1fc502cbe25def8f661b7bc"
uuid = "d7e528f0-a631-5988-bf34-fe36492bcfd7"
version = "2.13.2+0"

[[deps.FriBidi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1ed150b39aebcc805c26b93a8d0122c940f64ce2"
uuid = "559328eb-81f9-559d-9380-de523a88c83c"
version = "1.0.14+0"

[[deps.FunctionWrappers]]
git-tree-sha1 = "d62485945ce5ae9c0c48f124a84998d755bae00e"
uuid = "069b7b12-0de2-55c6-9aab-29f3d0a68a2e"
version = "1.1.3"

[[deps.FunctionWrappersWrappers]]
deps = ["FunctionWrappers"]
git-tree-sha1 = "b104d487b34566608f8b4e1c39fb0b10aa279ff8"
uuid = "77dc65aa-8811-40c2-897b-53d922fa7daf"
version = "0.1.3"

[[deps.Functors]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "64d8e93700c7a3f28f717d265382d52fac9fa1c1"
uuid = "d9f16b24-f501-4c13-a1f2-28368ffc5196"
version = "0.4.12"

[[deps.Future]]
deps = ["Random"]
uuid = "9fa8497b-333b-5362-9e8d-4d0656e87820"
version = "1.11.0"

[[deps.GLFW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libglvnd_jll", "Xorg_libXcursor_jll", "Xorg_libXi_jll", "Xorg_libXinerama_jll", "Xorg_libXrandr_jll", "libdecor_jll", "xkbcommon_jll"]
git-tree-sha1 = "532f9126ad901533af1d4f5c198867227a7bb077"
uuid = "0656b61e-2033-5cc2-a64a-77c0f6c09b89"
version = "3.4.0+1"

[[deps.GPUArraysCore]]
deps = ["Adapt"]
git-tree-sha1 = "2d6ca471a6c7b536127afccfa7564b5b39227fe0"
uuid = "46192b85-c4d5-4398-a991-12ede77f4527"
version = "0.1.5"

[[deps.GR]]
deps = ["Artifacts", "Base64", "DelimitedFiles", "Downloads", "GR_jll", "HTTP", "JSON", "Libdl", "LinearAlgebra", "Pkg", "Preferences", "Printf", "Random", "Serialization", "Sockets", "TOML", "Tar", "Test", "UUIDs", "p7zip_jll"]
git-tree-sha1 = "27442171f28c952804dede8ff72828a96f2bfc1f"
uuid = "28b8d3ca-fb5f-59d9-8090-bfdbd6d07a71"
version = "0.72.10"

[[deps.GR_jll]]
deps = ["Artifacts", "Bzip2_jll", "Cairo_jll", "FFMPEG_jll", "Fontconfig_jll", "FreeType2_jll", "GLFW_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pixman_jll", "Qt6Base_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "025d171a2847f616becc0f84c8dc62fe18f0f6dd"
uuid = "d2c73de3-f751-5644-a686-071e5b155ba9"
version = "0.72.10+0"

[[deps.GenericSchur]]
deps = ["LinearAlgebra", "Printf"]
git-tree-sha1 = "af49a0851f8113fcfae2ef5027c6d49d0acec39b"
uuid = "c145ed77-6b09-5dd9-b285-bf645a82121e"
version = "0.5.4"

[[deps.Gettext_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "9b02998aba7bf074d14de89f9d37ca24a1a0b046"
uuid = "78b55507-aeef-58d4-861c-77aaff3498b1"
version = "0.21.0+0"

[[deps.Glib_jll]]
deps = ["Artifacts", "Gettext_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Libiconv_jll", "Libmount_jll", "PCRE2_jll", "Zlib_jll"]
git-tree-sha1 = "674ff0db93fffcd11a3573986e550d66cd4fd71f"
uuid = "7746bdde-850d-59dc-9ae8-88ece973131d"
version = "2.80.5+0"

[[deps.Glob]]
git-tree-sha1 = "97285bbd5230dd766e9ef6749b80fc617126d496"
uuid = "c27321d9-0574-5035-807b-f59d2c89b15c"
version = "1.3.1"

[[deps.Graphite2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "344bf40dcab1073aca04aa0df4fb092f920e4011"
uuid = "3b182d85-2403-5c21-9c21-1e1f0cc25472"
version = "1.3.14+0"

[[deps.Graphs]]
deps = ["ArnoldiMethod", "Compat", "DataStructures", "Distributed", "Inflate", "LinearAlgebra", "Random", "SharedArrays", "SimpleTraits", "SparseArrays", "Statistics"]
git-tree-sha1 = "1dc470db8b1131cfc7fb4c115de89fe391b9e780"
uuid = "86223c79-3864-5bf0-83f7-82e725a168b6"
version = "1.12.0"

[[deps.Grisu]]
git-tree-sha1 = "53bb909d1151e57e2484c3d1b53e19552b887fb2"
uuid = "42e2da0e-8278-4e71-bc24-59509adca0fe"
version = "1.0.2"

[[deps.Groebner]]
deps = ["AbstractAlgebra", "Combinatorics", "ExprTools", "Logging", "MultivariatePolynomials", "PrecompileTools", "PrettyTables", "Primes", "Printf", "Random", "SIMD", "TimerOutputs"]
git-tree-sha1 = "6b505ef15e55bdc5bb3ddbcfebdff1c9e67081e8"
uuid = "0b43b601-686d-58a3-8a1c-6623616c7cd4"
version = "0.5.1"

[[deps.GroupsCore]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "6df9cd6ee79fc59feab33f63a1b3c9e95e2461d5"
uuid = "d5909c97-4eac-4ecc-a3dc-fdd0858a4120"
version = "0.4.2"

[[deps.HTTP]]
deps = ["Base64", "CodecZlib", "ConcurrentUtilities", "Dates", "ExceptionUnwrapping", "Logging", "LoggingExtras", "MbedTLS", "NetworkOptions", "OpenSSL", "Random", "SimpleBufferStream", "Sockets", "URIs", "UUIDs"]
git-tree-sha1 = "d1d712be3164d61d1fb98e7ce9bcbc6cc06b45ed"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "1.10.8"

[[deps.HarfBuzz_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "Graphite2_jll", "JLLWrappers", "Libdl", "Libffi_jll"]
git-tree-sha1 = "401e4f3f30f43af2c8478fc008da50096ea5240f"
uuid = "2e76f6c2-a576-52d4-95c1-20adfe4de566"
version = "8.3.1+0"

[[deps.HostCPUFeatures]]
deps = ["BitTwiddlingConvenienceFunctions", "IfElse", "Libdl", "Static"]
git-tree-sha1 = "8e070b599339d622e9a081d17230d74a5c473293"
uuid = "3e5b6fbb-0976-4d2c-9146-d79de83f2fb0"
version = "0.1.17"

[[deps.HypergeometricFunctions]]
deps = ["LinearAlgebra", "OpenLibm_jll", "SpecialFunctions"]
git-tree-sha1 = "7c4195be1649ae622304031ed46a2f4df989f1eb"
uuid = "34004b35-14d8-5ef3-9330-4cdb6864b03a"
version = "0.3.24"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "179267cfa5e712760cd43dcae385d7ea90cc25a4"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.5"

[[deps.HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "7134810b1afce04bbc1045ca1985fbe81ce17653"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.5"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "b6d6bfdd7ce25b0f9b2f6b3dd56b2673a66c8770"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.5"

[[deps.IfElse]]
git-tree-sha1 = "debdd00ffef04665ccbb3e150747a77560e8fad1"
uuid = "615f187c-cbe4-4ef1-ba3b-2fcf58d6d173"
version = "0.1.1"

[[deps.Inflate]]
git-tree-sha1 = "d1b1b796e47d94588b3757fe84fbf65a5ec4a80d"
uuid = "d25df0c9-e2be-5dd7-82c8-3ad0b3e990b9"
version = "0.1.5"

[[deps.IntegerMathUtils]]
git-tree-sha1 = "b8ffb903da9f7b8cf695a8bead8e01814aa24b30"
uuid = "18e54dd8-cb9d-406c-a71d-865a43cbb235"
version = "0.1.2"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"
version = "1.11.0"

[[deps.IntervalSets]]
git-tree-sha1 = "dba9ddf07f77f60450fe5d2e2beb9854d9a49bd0"
uuid = "8197267c-284f-5f27-9208-e0e47529a953"
version = "0.7.10"
weakdeps = ["Random", "RecipesBase", "Statistics"]

    [deps.IntervalSets.extensions]
    IntervalSetsRandomExt = "Random"
    IntervalSetsRecipesBaseExt = "RecipesBase"
    IntervalSetsStatisticsExt = "Statistics"

[[deps.IrrationalConstants]]
git-tree-sha1 = "630b497eafcc20001bba38a4651b327dcfc491d2"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.2.2"

[[deps.IterativeSolvers]]
deps = ["LinearAlgebra", "Printf", "Random", "RecipesBase", "SparseArrays"]
git-tree-sha1 = "59545b0a2b27208b0650df0a46b8e3019f85055b"
uuid = "42fd0dbc-a981-5370-80f2-aaf504508153"
version = "0.9.4"

[[deps.IteratorInterfaceExtensions]]
git-tree-sha1 = "a3f24677c21f5bbe9d2a714f95dcd58337fb2856"
uuid = "82899510-4779-5014-852e-03e436cf321d"
version = "1.0.0"

[[deps.JLFzf]]
deps = ["Pipe", "REPL", "Random", "fzf_jll"]
git-tree-sha1 = "39d64b09147620f5ffbf6b2d3255be3c901bec63"
uuid = "1019f520-868f-41f5-a6de-eb00f4b6a39c"
version = "0.1.8"

[[deps.JLLWrappers]]
deps = ["Artifacts", "Preferences"]
git-tree-sha1 = "be3dc50a92e5a386872a493a10050136d4703f9b"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.6.1"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "31e996f0a15c7b280ba9f76636b3ff9e2ae58c9a"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.4"

[[deps.JpegTurbo_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "25ee0be4d43d0269027024d75a24c24d6c6e590c"
uuid = "aacddb02-875f-59d6-b918-886e6ef4fbf8"
version = "3.0.4+0"

[[deps.JuliaFormatter]]
deps = ["CSTParser", "CommonMark", "DataStructures", "Glob", "PrecompileTools", "TOML", "Tokenize"]
git-tree-sha1 = "59cf7ad64f1b0708a4fa4369879d33bad3239b56"
uuid = "98e50ef6-434e-11e9-1051-2b60c6c9e899"
version = "1.0.62"

[[deps.JumpProcesses]]
deps = ["ArrayInterface", "DataStructures", "DiffEqBase", "DocStringExtensions", "FunctionWrappers", "Graphs", "LinearAlgebra", "Markdown", "PoissonRandom", "Random", "RandomNumbers", "RecursiveArrayTools", "Reexport", "SciMLBase", "StaticArrays", "UnPack"]
git-tree-sha1 = "c451feb97251965a9fe40bacd62551a72cc5902c"
uuid = "ccbc3e58-028d-4f4c-8cd5-9ae44345cda5"
version = "9.10.1"
weakdeps = ["FastBroadcast"]

    [deps.JumpProcesses.extensions]
    JumpProcessFastBroadcastExt = "FastBroadcast"

[[deps.KLU]]
deps = ["LinearAlgebra", "SparseArrays", "SuiteSparse_jll"]
git-tree-sha1 = "884c2968c2e8e7e6bf5956af88cb46aa745c854b"
uuid = "ef3ab10e-7fda-4108-b977-705223b18434"
version = "0.4.1"

[[deps.Krylov]]
deps = ["LinearAlgebra", "Printf", "SparseArrays"]
git-tree-sha1 = "267dad6b4b7b5d529c76d40ff48d33f7e94cb834"
uuid = "ba0b0d4f-ebba-5204-a429-3ac8c609bfb7"
version = "0.9.6"

[[deps.KrylovKit]]
deps = ["ChainRulesCore", "GPUArraysCore", "LinearAlgebra", "Printf"]
git-tree-sha1 = "5cebb47f472f086f7dd31fb8e738a8db728f1f84"
uuid = "0b1a1467-8014-51b9-945f-bf0ae24f4b77"
version = "0.6.1"

[[deps.LAME_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "170b660facf5df5de098d866564877e119141cbd"
uuid = "c1c5ebd0-6772-5130-a774-d5fcae4a789d"
version = "3.100.2+0"

[[deps.LERC_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "bf36f528eec6634efc60d7ec062008f171071434"
uuid = "88015f11-f218-50d7-93a8-a6af411a945d"
version = "3.0.0+1"

[[deps.LLVMOpenMP_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "78211fb6cbc872f77cad3fc0b6cf647d923f4929"
uuid = "1d63c593-3942-5779-bab2-d838dc0a180e"
version = "18.1.7+0"

[[deps.LZO_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "854a9c268c43b77b0a27f22d7fab8d33cdb3a731"
uuid = "dd4b983a-f0e5-5f8d-a1b7-129d4a5fb1ac"
version = "2.10.2+1"

[[deps.LaTeXStrings]]
git-tree-sha1 = "dda21b8cbd6a6c40d9d02a73230f9d70fed6918c"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.4.0"

[[deps.LabelledArrays]]
deps = ["ArrayInterface", "ChainRulesCore", "ForwardDiff", "LinearAlgebra", "MacroTools", "PreallocationTools", "RecursiveArrayTools", "StaticArrays"]
git-tree-sha1 = "d1f981fba6eb3ec393eede4821bca3f2b7592cd4"
uuid = "2ee39098-c373-598a-b85f-a56591580800"
version = "1.15.1"

[[deps.LambertW]]
git-tree-sha1 = "c5ffc834de5d61d00d2b0e18c96267cffc21f648"
uuid = "984bce1d-4616-540c-a9ee-88d1112d94c9"
version = "0.4.6"

[[deps.Latexify]]
deps = ["Formatting", "InteractiveUtils", "LaTeXStrings", "MacroTools", "Markdown", "OrderedCollections", "Printf", "Requires"]
git-tree-sha1 = "8c57307b5d9bb3be1ff2da469063628631d4d51e"
uuid = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
version = "0.15.21"

    [deps.Latexify.extensions]
    DataFramesExt = "DataFrames"
    DiffEqBiologicalExt = "DiffEqBiological"
    ParameterizedFunctionsExt = "DiffEqBase"
    SymEngineExt = "SymEngine"

    [deps.Latexify.weakdeps]
    DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
    DiffEqBase = "2b5f629d-d688-5b77-993f-72d75c75574e"
    DiffEqBiological = "eb300fae-53e8-50a0-950c-e21f52c2b7e0"
    SymEngine = "123dc426-2d89-5057-bbad-38513e3affd8"

[[deps.LayoutPointers]]
deps = ["ArrayInterface", "LinearAlgebra", "ManualMemory", "SIMDTypes", "Static", "StaticArrayInterface"]
git-tree-sha1 = "a9eaadb366f5493a5654e843864c13d8b107548c"
uuid = "10f19ff3-798f-405d-979b-55457f8fc047"
version = "0.1.17"

[[deps.Lazy]]
deps = ["MacroTools"]
git-tree-sha1 = "1370f8202dac30758f3c345f9909b97f53d87d3f"
uuid = "50d2b5c4-7a5e-59d5-8109-a42b560f39c0"
version = "0.15.1"

[[deps.LevyArea]]
deps = ["LinearAlgebra", "Random", "SpecialFunctions"]
git-tree-sha1 = "56513a09b8e0ae6485f34401ea9e2f31357958ec"
uuid = "2d8b4e74-eb68-11e8-0fb9-d5eb67b50637"
version = "1.0.0"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.4"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "8.6.0+0"

[[deps.LibGit2]]
deps = ["Base64", "LibGit2_jll", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"
version = "1.11.0"

[[deps.LibGit2_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll"]
uuid = "e37daf67-58a4-590a-8e99-b0245dd2ffc5"
version = "1.7.2+0"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.11.0+1"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"
version = "1.11.0"

[[deps.Libffi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "0b4a5d71f3e5200a7dff793393e09dfc2d874290"
uuid = "e9f186c6-92d2-5b65-8a66-fee21dc1b490"
version = "3.2.2+1"

[[deps.Libgcrypt_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgpg_error_jll"]
git-tree-sha1 = "9fd170c4bbfd8b935fdc5f8b7aa33532c991a673"
uuid = "d4300ac3-e22c-5743-9152-c294e39db1e4"
version = "1.8.11+0"

[[deps.Libglvnd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll", "Xorg_libXext_jll"]
git-tree-sha1 = "6f73d1dd803986947b2c750138528a999a6c7733"
uuid = "7e76a0d4-f3c7-5321-8279-8d96eeed0f29"
version = "1.6.0+0"

[[deps.Libgpg_error_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "fbb1f2bef882392312feb1ede3615ddc1e9b99ed"
uuid = "7add5ba3-2f88-524e-9cd5-f83b8a55f7b8"
version = "1.49.0+0"

[[deps.Libiconv_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "f9557a255370125b405568f9767d6d195822a175"
uuid = "94ce4f54-9a6c-5748-9c1c-f9c7231a4531"
version = "1.17.0+0"

[[deps.Libmount_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "0c4f9c4f1a50d8f35048fa0532dabbadf702f81e"
uuid = "4b2f31a3-9ecc-558c-b454-b3730dcb73e9"
version = "2.40.1+0"

[[deps.Libtiff_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "LERC_jll", "Libdl", "XZ_jll", "Zlib_jll", "Zstd_jll"]
git-tree-sha1 = "2da088d113af58221c52828a80378e16be7d037a"
uuid = "89763e89-9b03-5906-acba-b20f662cd828"
version = "4.5.1+1"

[[deps.Libuuid_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "5ee6203157c120d79034c748a2acba45b82b8807"
uuid = "38a345b3-de98-5d2b-a5d3-14cd9215e700"
version = "2.40.1+0"

[[deps.LineSearches]]
deps = ["LinearAlgebra", "NLSolversBase", "NaNMath", "Parameters", "Printf"]
git-tree-sha1 = "e4c3be53733db1051cc15ecf573b1042b3a712a1"
uuid = "d3d80556-e9d4-5f37-9878-2ab0fcc64255"
version = "7.3.0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
version = "1.11.0"

[[deps.LinearSolve]]
deps = ["ArrayInterface", "DocStringExtensions", "EnumX", "FastLapackInterface", "GPUArraysCore", "IterativeSolvers", "KLU", "Krylov", "KrylovKit", "LinearAlgebra", "Preferences", "RecursiveFactorization", "Reexport", "SciMLBase", "SciMLOperators", "Setfield", "SnoopPrecompile", "SparseArrays", "Sparspak", "SuiteSparse", "UnPack"]
git-tree-sha1 = "4a4f8cc7a59fadbb02d1852d1e0cef5dca3a9460"
uuid = "7ed4a6bd-45f5-4d41-b270-4a48e9bafcae"
version = "1.42.0"

    [deps.LinearSolve.extensions]
    LinearSolveHYPRE = "HYPRE"

    [deps.LinearSolve.weakdeps]
    HYPRE = "b5ffcf37-a2bd-41ab-a3da-4bd9bc8ad771"

[[deps.LogExpFunctions]]
deps = ["DocStringExtensions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "a2d09619db4e765091ee5c6ffe8872849de0feea"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.28"

    [deps.LogExpFunctions.extensions]
    LogExpFunctionsChainRulesCoreExt = "ChainRulesCore"
    LogExpFunctionsChangesOfVariablesExt = "ChangesOfVariables"
    LogExpFunctionsInverseFunctionsExt = "InverseFunctions"

    [deps.LogExpFunctions.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    ChangesOfVariables = "9e997f8a-9a97-42d5-a9f1-ce6bfc15e2c0"
    InverseFunctions = "3587e190-3f89-42d0-90ee-14403ec27112"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"
version = "1.11.0"

[[deps.LoggingExtras]]
deps = ["Dates", "Logging"]
git-tree-sha1 = "c1dd6d7978c12545b4179fb6153b9250c96b0075"
uuid = "e6f89c97-d47a-5376-807f-9c37f3926c36"
version = "1.0.3"

[[deps.LoopVectorization]]
deps = ["ArrayInterface", "CPUSummary", "CloseOpenIntervals", "DocStringExtensions", "HostCPUFeatures", "IfElse", "LayoutPointers", "LinearAlgebra", "OffsetArrays", "PolyesterWeave", "PrecompileTools", "SIMDTypes", "SLEEFPirates", "Static", "StaticArrayInterface", "ThreadingUtilities", "UnPack", "VectorizationBase"]
git-tree-sha1 = "8084c25a250e00ae427a379a5b607e7aed96a2dd"
uuid = "bdcacae8-1622-11e9-2a5c-532679323890"
version = "0.12.171"
weakdeps = ["ChainRulesCore", "ForwardDiff", "SpecialFunctions"]

    [deps.LoopVectorization.extensions]
    ForwardDiffExt = ["ChainRulesCore", "ForwardDiff"]
    SpecialFunctionsExt = "SpecialFunctions"

[[deps.MIMEs]]
git-tree-sha1 = "65f28ad4b594aebe22157d6fac869786a255b7eb"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "0.1.4"

[[deps.MLStyle]]
git-tree-sha1 = "bc38dff0548128765760c79eb7388a4b37fae2c8"
uuid = "d8e11817-5142-5d16-987a-aa16d5891078"
version = "0.4.17"

[[deps.MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "2fa9ee3e63fd3a4f7a9a4f4744a52f4856de82df"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.13"

[[deps.ManualMemory]]
git-tree-sha1 = "bcaef4fc7a0cfe2cba636d84cda54b5e4e4ca3cd"
uuid = "d125e4d3-2237-4719-b19c-fa641b8a4667"
version = "0.1.8"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"
version = "1.11.0"

[[deps.MbedTLS]]
deps = ["Dates", "MbedTLS_jll", "MozillaCACerts_jll", "NetworkOptions", "Random", "Sockets"]
git-tree-sha1 = "c067a280ddc25f196b5e7df3877c6b226d390aaf"
uuid = "739be429-bea8-5141-9913-cc70e7f3736d"
version = "1.1.9"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.6+0"

[[deps.Measures]]
git-tree-sha1 = "c13304c81eec1ed3af7fc20e75fb6b26092a1102"
uuid = "442fdcdd-2543-5da2-b0f3-8c86c306513e"
version = "0.3.2"

[[deps.Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "ec4f7fbeab05d7747bdf98eb74d130a2a2ed298d"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.2.0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"
version = "1.11.0"

[[deps.ModelingToolkit]]
deps = ["AbstractTrees", "ArrayInterface", "Combinatorics", "Compat", "ConstructionBase", "DataStructures", "DiffEqBase", "DiffEqCallbacks", "DiffRules", "Distributed", "Distributions", "DocStringExtensions", "DomainSets", "ForwardDiff", "FunctionWrappersWrappers", "Graphs", "IfElse", "InteractiveUtils", "JuliaFormatter", "JumpProcesses", "LabelledArrays", "Latexify", "Libdl", "LinearAlgebra", "MLStyle", "MacroTools", "NaNMath", "OrdinaryDiffEq", "PrecompileTools", "RecursiveArrayTools", "Reexport", "RuntimeGeneratedFunctions", "SciMLBase", "Serialization", "Setfield", "SimpleNonlinearSolve", "SparseArrays", "SpecialFunctions", "StaticArrays", "SymbolicIndexingInterface", "SymbolicUtils", "Symbolics", "URIs", "UnPack", "Unitful"]
git-tree-sha1 = "87a45c453295c1640a1fd011a85e42fda7a78d15"
uuid = "961ee093-0014-501f-94e3-6117800e7a78"
version = "8.70.0"

    [deps.ModelingToolkit.extensions]
    MTKDeepDiffsExt = "DeepDiffs"

    [deps.ModelingToolkit.weakdeps]
    DeepDiffs = "ab62b9b5-e342-54a8-a765-a90f495de1a6"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2023.12.12"

[[deps.MuladdMacro]]
git-tree-sha1 = "cac9cc5499c25554cba55cd3c30543cff5ca4fab"
uuid = "46d2c3a1-f734-5fdb-9937-b9b9aeba4221"
version = "0.2.4"

[[deps.MultivariatePolynomials]]
deps = ["ChainRulesCore", "DataStructures", "LinearAlgebra", "MutableArithmetics"]
git-tree-sha1 = "8d39779e29f80aa6c071e7ac17101c6e31f075d7"
uuid = "102ac46a-7ee4-5c85-9060-abc95bfdeaa3"
version = "0.5.7"

[[deps.MutableArithmetics]]
deps = ["LinearAlgebra", "SparseArrays", "Test"]
git-tree-sha1 = "90077f1e79de8c9c7c8a90644494411111f4e07b"
uuid = "d8a4904e-b15c-11e9-3269-09a3773c0cb0"
version = "1.5.2"

[[deps.NLSolversBase]]
deps = ["DiffResults", "Distributed", "FiniteDiff", "ForwardDiff"]
git-tree-sha1 = "a0b464d183da839699f4c79e7606d9d186ec172c"
uuid = "d41bc354-129a-5804-8e4c-c37616107c6c"
version = "7.8.3"

[[deps.NLsolve]]
deps = ["Distances", "LineSearches", "LinearAlgebra", "NLSolversBase", "Printf", "Reexport"]
git-tree-sha1 = "019f12e9a1a7880459d0173c182e6a99365d7ac1"
uuid = "2774e3e8-f4cf-5e23-947b-6d7e65073b56"
version = "4.5.1"

[[deps.NaNMath]]
deps = ["OpenLibm_jll"]
git-tree-sha1 = "0877504529a3e5c3343c6f8b4c0381e57e4387e4"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "1.0.2"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.NonlinearSolve]]
deps = ["ArrayInterface", "DiffEqBase", "EnumX", "FiniteDiff", "ForwardDiff", "LinearAlgebra", "LinearSolve", "RecursiveArrayTools", "Reexport", "SciMLBase", "SimpleNonlinearSolve", "SnoopPrecompile", "SparseArrays", "SparseDiffTools", "StaticArraysCore", "UnPack"]
git-tree-sha1 = "a6000c813371cd3cd9cbbdf8a356fc3a97138d92"
uuid = "8913a72c-1f9b-4ce2-8d82-65094dcecaec"
version = "1.6.0"

[[deps.OffsetArrays]]
git-tree-sha1 = "1a27764e945a152f7ca7efa04de513d473e9542e"
uuid = "6fe1bfb0-de20-5000-8ca7-80f57d26f881"
version = "1.14.1"
weakdeps = ["Adapt"]

    [deps.OffsetArrays.extensions]
    OffsetArraysAdaptExt = "Adapt"

[[deps.Ogg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "887579a3eb005446d514ab7aeac5d1d027658b8f"
uuid = "e7412a2a-1a6e-54c0-be00-318e2571c051"
version = "1.3.5+1"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.27+1"

[[deps.OpenLibm_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"
version = "0.8.1+2"

[[deps.OpenSSL]]
deps = ["BitFlags", "Dates", "MozillaCACerts_jll", "OpenSSL_jll", "Sockets"]
git-tree-sha1 = "38cb508d080d21dc1128f7fb04f20387ed4c0af4"
uuid = "4d8831e6-92b7-49fb-bdf8-b643e874388c"
version = "1.4.3"

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "7493f61f55a6cce7325f197443aa80d32554ba10"
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "3.0.15+1"

[[deps.OpenSpecFun_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "13652491f6856acfd2db29360e1bbcd4565d04f1"
uuid = "efe28fd5-8261-553b-a9e1-b2916fc3738e"
version = "0.5.5+0"

[[deps.Optim]]
deps = ["Compat", "FillArrays", "ForwardDiff", "LineSearches", "LinearAlgebra", "NLSolversBase", "NaNMath", "Parameters", "PositiveFactorizations", "Printf", "SparseArrays", "StatsBase"]
git-tree-sha1 = "d9b79c4eed437421ac4285148fcadf42e0700e89"
uuid = "429524aa-4258-5aef-a3af-852621145aeb"
version = "1.9.4"

    [deps.Optim.extensions]
    OptimMOIExt = "MathOptInterface"

    [deps.Optim.weakdeps]
    MathOptInterface = "b8f27783-ece8-5eb3-8dc8-9495eed66fee"

[[deps.Opus_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "6703a85cb3781bd5909d48730a67205f3f31a575"
uuid = "91d4177d-7536-5919-b921-800302f37372"
version = "1.3.3+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "dfdf5519f235516220579f949664f1bf44e741c5"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.6.3"

[[deps.OrdinaryDiffEq]]
deps = ["ADTypes", "Adapt", "ArrayInterface", "DataStructures", "DiffEqBase", "DocStringExtensions", "ExponentialUtilities", "FastBroadcast", "FastClosures", "FiniteDiff", "ForwardDiff", "FunctionWrappersWrappers", "IfElse", "LineSearches", "LinearAlgebra", "LinearSolve", "Logging", "LoopVectorization", "MacroTools", "MuladdMacro", "NLsolve", "NonlinearSolve", "Polyester", "PreallocationTools", "PrecompileTools", "Preferences", "RecursiveArrayTools", "Reexport", "SciMLBase", "SciMLNLSolve", "SciMLOperators", "SimpleNonlinearSolve", "SimpleUnPack", "SparseArrays", "SparseDiffTools", "StaticArrayInterface", "StaticArrays", "TruncatedStacktraces"]
git-tree-sha1 = "7f758238ce4202ced5e08aa2903d19d3a4f0dd7c"
uuid = "1dea7af3-3e70-54e6-95c3-0bf5283fa5ed"
version = "6.52.0"

[[deps.PCRE2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "efcefdf7-47ab-520b-bdef-62a2eaa19f15"
version = "10.42.0+1"

[[deps.PDMats]]
deps = ["LinearAlgebra", "SparseArrays", "SuiteSparse"]
git-tree-sha1 = "949347156c25054de2db3b166c52ac4728cbad65"
uuid = "90014a1f-27ba-587c-ab20-58faa44d9150"
version = "0.11.31"

[[deps.PackageExtensionCompat]]
git-tree-sha1 = "fb28e33b8a95c4cee25ce296c817d89cc2e53518"
uuid = "65ce6f38-6b18-4e1d-a461-8949797d7930"
version = "1.0.2"
weakdeps = ["Requires", "TOML"]

[[deps.Pango_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "FriBidi_jll", "Glib_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl"]
git-tree-sha1 = "e127b609fb9ecba6f201ba7ab753d5a605d53801"
uuid = "36c8627f-9965-5494-a995-c6b170f724f3"
version = "1.54.1+0"

[[deps.ParameterizedFunctions]]
deps = ["DataStructures", "DiffEqBase", "DocStringExtensions", "Latexify", "LinearAlgebra", "ModelingToolkit", "Reexport", "SciMLBase"]
git-tree-sha1 = "78ab7ecc18b307e00abba28bb29d7ed6bf11b9f7"
uuid = "65888b18-ceab-5e60-b2b9-181511a3b968"
version = "5.15.0"

[[deps.Parameters]]
deps = ["OrderedCollections", "UnPack"]
git-tree-sha1 = "34c0e9ad262e5f7fc75b10a9952ca7692cfc5fbe"
uuid = "d96e819e-fc66-5662-9728-84c9c7592b0a"
version = "0.12.3"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "8489905bcdbcfac64d1daa51ca07c0d8f0283821"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.8.1"

[[deps.Pipe]]
git-tree-sha1 = "6842804e7867b115ca9de748a0cf6b364523c16d"
uuid = "b98c9c47-44ae-5843-9183-064241ee97a0"
version = "1.3.0"

[[deps.Pixman_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "LLVMOpenMP_jll", "Libdl"]
git-tree-sha1 = "35621f10a7531bc8fa58f74610b1bfb70a3cfc6b"
uuid = "30392449-352a-5448-841d-b1acce4e97dc"
version = "0.43.4+0"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "Random", "SHA", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.11.0"
weakdeps = ["REPL"]

    [deps.Pkg.extensions]
    REPLExt = "REPL"

[[deps.PlotThemes]]
deps = ["PlotUtils", "Statistics"]
git-tree-sha1 = "6e55c6841ce3411ccb3457ee52fc48cb698d6fb0"
uuid = "ccf2f8ad-2431-5c83-bf29-c5338b663b6a"
version = "3.2.0"

[[deps.PlotUtils]]
deps = ["ColorSchemes", "Colors", "Dates", "PrecompileTools", "Printf", "Random", "Reexport", "Statistics"]
git-tree-sha1 = "7b1a9df27f072ac4c9c7cbe5efb198489258d1f5"
uuid = "995b91a9-d308-5afd-9ec6-746e21dbc043"
version = "1.4.1"

[[deps.Plots]]
deps = ["Base64", "Contour", "Dates", "Downloads", "FFMPEG", "FixedPointNumbers", "GR", "JLFzf", "JSON", "LaTeXStrings", "Latexify", "LinearAlgebra", "Measures", "NaNMath", "Pkg", "PlotThemes", "PlotUtils", "PrecompileTools", "Preferences", "Printf", "REPL", "Random", "RecipesBase", "RecipesPipeline", "Reexport", "RelocatableFolders", "Requires", "Scratch", "Showoff", "SparseArrays", "Statistics", "StatsBase", "UUIDs", "UnicodeFun", "UnitfulLatexify", "Unzip"]
git-tree-sha1 = "9f8675a55b37a70aa23177ec110f6e3f4dd68466"
uuid = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
version = "1.38.17"

    [deps.Plots.extensions]
    FileIOExt = "FileIO"
    GeometryBasicsExt = "GeometryBasics"
    IJuliaExt = "IJulia"
    ImageInTerminalExt = "ImageInTerminal"
    UnitfulExt = "Unitful"

    [deps.Plots.weakdeps]
    FileIO = "5789e2e9-d7fb-5bc7-8068-2c6fae9b9549"
    GeometryBasics = "5c1252a2-5f33-56bf-86c9-59e7332b4326"
    IJulia = "7073ff75-c697-5162-941a-fcdaad2a7d2a"
    ImageInTerminal = "d8c32880-2388-543b-8c61-d9f865259254"
    Unitful = "1986cc42-f94f-5a68-af5c-568840ba703d"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "eba4810d5e6a01f612b948c9fa94f905b49087b0"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.60"

[[deps.PoissonRandom]]
deps = ["Random"]
git-tree-sha1 = "a0f1159c33f846aa77c3f30ebbc69795e5327152"
uuid = "e409e4f3-bfea-5376-8464-e040bb5c01ab"
version = "0.4.4"

[[deps.Polyester]]
deps = ["ArrayInterface", "BitTwiddlingConvenienceFunctions", "CPUSummary", "IfElse", "ManualMemory", "PolyesterWeave", "Static", "StaticArrayInterface", "StrideArraysCore", "ThreadingUtilities"]
git-tree-sha1 = "6d38fea02d983051776a856b7df75b30cf9a3c1f"
uuid = "f517fe37-dbe3-4b94-8317-1923a5111588"
version = "0.7.16"

[[deps.PolyesterWeave]]
deps = ["BitTwiddlingConvenienceFunctions", "CPUSummary", "IfElse", "Static", "ThreadingUtilities"]
git-tree-sha1 = "645bed98cd47f72f67316fd42fc47dee771aefcd"
uuid = "1d0040c9-8b98-4ee7-8388-3f51789ca0ad"
version = "0.2.2"

[[deps.PositiveFactorizations]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "17275485f373e6673f7e7f97051f703ed5b15b20"
uuid = "85a6dd25-e78a-55b7-8502-1745935b8125"
version = "0.2.4"

[[deps.PreallocationTools]]
deps = ["Adapt", "ArrayInterface", "ForwardDiff"]
git-tree-sha1 = "6c62ce45f268f3f958821a1e5192cf91c75ae89c"
uuid = "d236fae5-4411-538c-8e31-a6e3d9e00b46"
version = "0.4.24"

    [deps.PreallocationTools.extensions]
    PreallocationToolsReverseDiffExt = "ReverseDiff"

    [deps.PreallocationTools.weakdeps]
    ReverseDiff = "37e2e3b7-166d-5795-8a7a-e32c996b4267"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "5aa36f7049a63a1528fe8f7c3f2113413ffd4e1f"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.2.1"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "9306f6085165d270f7e3db02af26a400d580f5c6"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.4.3"

[[deps.PrettyTables]]
deps = ["Crayons", "LaTeXStrings", "Markdown", "PrecompileTools", "Printf", "Reexport", "StringManipulation", "Tables"]
git-tree-sha1 = "1101cd475833706e4d0e7b122218257178f48f34"
uuid = "08abe8d2-0d0c-5749-adfa-8a2ac140af0d"
version = "2.4.0"

[[deps.Primes]]
deps = ["IntegerMathUtils"]
git-tree-sha1 = "cb420f77dc474d23ee47ca8d14c90810cafe69e7"
uuid = "27ebfcd6-29c5-5fa9-bf4b-fb8fc14df3ae"
version = "0.5.6"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"
version = "1.11.0"

[[deps.PtrArrays]]
git-tree-sha1 = "77a42d78b6a92df47ab37e177b2deac405e1c88f"
uuid = "43287f4e-b6f4-7ad1-bb20-aadabca52c3d"
version = "1.2.1"

[[deps.Qt6Base_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Fontconfig_jll", "Glib_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "OpenSSL_jll", "Vulkan_Loader_jll", "Xorg_libSM_jll", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Xorg_libxcb_jll", "Xorg_xcb_util_cursor_jll", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_keysyms_jll", "Xorg_xcb_util_renderutil_jll", "Xorg_xcb_util_wm_jll", "Zlib_jll", "libinput_jll", "xkbcommon_jll"]
git-tree-sha1 = "37b7bb7aabf9a085e0044307e1717436117f2b3b"
uuid = "c0090381-4147-56d7-9ebc-da0b1113ec56"
version = "6.5.3+1"

[[deps.QuadGK]]
deps = ["DataStructures", "LinearAlgebra"]
git-tree-sha1 = "cda3b045cf9ef07a08ad46731f5a3165e56cf3da"
uuid = "1fd47b50-473d-5c70-9696-f719f8f3bcdc"
version = "2.11.1"

    [deps.QuadGK.extensions]
    QuadGKEnzymeExt = "Enzyme"

    [deps.QuadGK.weakdeps]
    Enzyme = "7da242da-08ed-463a-9acd-ee780be4f1d9"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "StyledStrings", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"
version = "1.11.0"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"
version = "1.11.0"

[[deps.Random123]]
deps = ["Random", "RandomNumbers"]
git-tree-sha1 = "4743b43e5a9c4a2ede372de7061eed81795b12e7"
uuid = "74087812-796a-5b5d-8853-05524746bad3"
version = "1.7.0"

[[deps.RandomExtensions]]
deps = ["Random", "SparseArrays"]
git-tree-sha1 = "b8a399e95663485820000f26b6a43c794e166a49"
uuid = "fb686558-2515-59ef-acaa-46db3789a887"
version = "0.4.4"

[[deps.RandomNumbers]]
deps = ["Random"]
git-tree-sha1 = "c6ec94d2aaba1ab2ff983052cf6a606ca5985902"
uuid = "e6cf234a-135c-5ec9-84dd-332b85af5143"
version = "1.6.0"

[[deps.RecipesBase]]
deps = ["PrecompileTools"]
git-tree-sha1 = "5c3d09cc4f31f5fc6af001c250bf1278733100ff"
uuid = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
version = "1.3.4"

[[deps.RecipesPipeline]]
deps = ["Dates", "NaNMath", "PlotUtils", "PrecompileTools", "RecipesBase"]
git-tree-sha1 = "45cf9fd0ca5839d06ef333c8201714e888486342"
uuid = "01d81517-befc-4cb6-b9ec-a95719d0359c"
version = "0.6.12"

[[deps.RecursiveArrayTools]]
deps = ["Adapt", "ArrayInterface", "DocStringExtensions", "GPUArraysCore", "IteratorInterfaceExtensions", "LinearAlgebra", "RecipesBase", "Requires", "StaticArraysCore", "Statistics", "SymbolicIndexingInterface", "Tables"]
git-tree-sha1 = "d7087c013e8a496ff396bae843b1e16d9a30ede8"
uuid = "731186ca-8d62-57ce-b412-fbd966d074cd"
version = "2.38.10"

    [deps.RecursiveArrayTools.extensions]
    RecursiveArrayToolsMeasurementsExt = "Measurements"
    RecursiveArrayToolsMonteCarloMeasurementsExt = "MonteCarloMeasurements"
    RecursiveArrayToolsTrackerExt = "Tracker"
    RecursiveArrayToolsZygoteExt = "Zygote"

    [deps.RecursiveArrayTools.weakdeps]
    Measurements = "eff96d63-e80a-5855-80a2-b1b0885c5ab7"
    MonteCarloMeasurements = "0987c9cc-fe09-11e8-30f0-b96dd679fdca"
    Tracker = "9f7883ad-71c0-57eb-9f7f-b5c9e6d3789c"
    Zygote = "e88e6eb3-aa80-5325-afca-941959d7151f"

[[deps.RecursiveFactorization]]
deps = ["LinearAlgebra", "LoopVectorization", "Polyester", "PrecompileTools", "StrideArraysCore", "TriangularSolve"]
git-tree-sha1 = "6db1a75507051bc18bfa131fbc7c3f169cc4b2f6"
uuid = "f2c3362d-daeb-58d1-803e-2bc74f2840b4"
version = "0.2.23"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.RelocatableFolders]]
deps = ["SHA", "Scratch"]
git-tree-sha1 = "ffdaf70d81cf6ff22c2b6e733c900c3321cab864"
uuid = "05181044-ff0b-4ac5-8273-598c1e38db00"
version = "1.0.1"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "838a3a4188e2ded87a4f9f184b4b0d78a1e91cb7"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.0"

[[deps.ResettableStacks]]
deps = ["StaticArrays"]
git-tree-sha1 = "256eeeec186fa7f26f2801732774ccf277f05db9"
uuid = "ae5879a3-cd67-5da8-be7f-38c6eb64a37b"
version = "1.1.1"

[[deps.Rmath]]
deps = ["Random", "Rmath_jll"]
git-tree-sha1 = "852bd0f55565a9e973fcfee83a84413270224dc4"
uuid = "79098fc4-a85e-5d69-aa6a-4863f24498fa"
version = "0.8.0"

[[deps.Rmath_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "58cdd8fb2201a6267e1db87ff148dd6c1dbd8ad8"
uuid = "f50d1b31-88e8-58de-be2c-1cc44531875f"
version = "0.5.1+0"

[[deps.RuntimeGeneratedFunctions]]
deps = ["ExprTools", "SHA", "Serialization"]
git-tree-sha1 = "04c968137612c4a5629fa531334bb81ad5680f00"
uuid = "7e49a35a-f44a-4d26-94aa-eba1b4ca6b47"
version = "0.5.13"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.SIMD]]
deps = ["PrecompileTools"]
git-tree-sha1 = "98ca7c29edd6fc79cd74c61accb7010a4e7aee33"
uuid = "fdea26ae-647d-5447-a871-4b548cad5224"
version = "3.6.0"

[[deps.SIMDTypes]]
git-tree-sha1 = "330289636fb8107c5f32088d2741e9fd7a061a5c"
uuid = "94e857df-77ce-4151-89e5-788b33177be4"
version = "0.1.0"

[[deps.SLEEFPirates]]
deps = ["IfElse", "Static", "VectorizationBase"]
git-tree-sha1 = "456f610ca2fbd1c14f5fcf31c6bfadc55e7d66e0"
uuid = "476501e8-09a2-5ece-8869-fb82de89a1fa"
version = "0.6.43"

[[deps.SciMLBase]]
deps = ["ADTypes", "ArrayInterface", "ChainRulesCore", "CommonSolve", "ConstructionBase", "Distributed", "DocStringExtensions", "EnumX", "FillArrays", "FunctionWrappersWrappers", "IteratorInterfaceExtensions", "LinearAlgebra", "Logging", "Markdown", "PrecompileTools", "Preferences", "RecipesBase", "RecursiveArrayTools", "Reexport", "RuntimeGeneratedFunctions", "SciMLOperators", "StaticArraysCore", "Statistics", "SymbolicIndexingInterface", "Tables", "TruncatedStacktraces", "ZygoteRules"]
git-tree-sha1 = "916b8a94c0d61fa5f7c5295649d3746afb866aff"
uuid = "0bca4576-84f4-4d90-8ffe-ffa030f20462"
version = "1.98.1"

    [deps.SciMLBase.extensions]
    ZygoteExt = "Zygote"

    [deps.SciMLBase.weakdeps]
    Zygote = "e88e6eb3-aa80-5325-afca-941959d7151f"

[[deps.SciMLNLSolve]]
deps = ["DiffEqBase", "LineSearches", "NLsolve", "Reexport", "SciMLBase"]
git-tree-sha1 = "765b788339abd7d983618c09cfc0192e2b6b15fd"
uuid = "e9a6253c-8580-4d32-9898-8661bb511710"
version = "0.1.9"

[[deps.SciMLOperators]]
deps = ["ArrayInterface", "DocStringExtensions", "Lazy", "LinearAlgebra", "Setfield", "SparseArrays", "StaticArraysCore", "Tricks"]
git-tree-sha1 = "6a657a73322170eec86fb427661dbee079b85bff"
uuid = "c0aeaf25-5076-4817-a8d5-81caf7dfa961"
version = "0.2.12"

[[deps.Scratch]]
deps = ["Dates"]
git-tree-sha1 = "3bac05bc7e74a75fd9cba4295cde4045d9fe2386"
uuid = "6c6a2e73-6563-6170-7368-637461726353"
version = "1.2.1"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"
version = "1.11.0"

[[deps.Setfield]]
deps = ["ConstructionBase", "Future", "MacroTools", "StaticArraysCore"]
git-tree-sha1 = "e2cc6d8c88613c05e1defb55170bf5ff211fbeac"
uuid = "efcf1570-3423-57d1-acb7-fd33fddbac46"
version = "1.1.1"

[[deps.SharedArrays]]
deps = ["Distributed", "Mmap", "Random", "Serialization"]
uuid = "1a1011a3-84de-559e-8e89-a11a2f7dc383"
version = "1.11.0"

[[deps.Showoff]]
deps = ["Dates", "Grisu"]
git-tree-sha1 = "91eddf657aca81df9ae6ceb20b959ae5653ad1de"
uuid = "992d4aef-0814-514b-bc4d-f2e9a6c4116f"
version = "1.0.3"

[[deps.SimpleBufferStream]]
git-tree-sha1 = "f305871d2f381d21527c770d4788c06c097c9bc1"
uuid = "777ac1f9-54b0-4bf8-805c-2214025038e7"
version = "1.2.0"

[[deps.SimpleNonlinearSolve]]
deps = ["ArrayInterface", "DiffEqBase", "FiniteDiff", "ForwardDiff", "LinearAlgebra", "PackageExtensionCompat", "PrecompileTools", "Reexport", "SciMLBase", "StaticArraysCore"]
git-tree-sha1 = "15ff97fa4881133caa324dacafe28b5ac47ad8a2"
uuid = "727e6d20-b764-4bd8-a329-72de5adea6c7"
version = "0.1.23"

    [deps.SimpleNonlinearSolve.extensions]
    SimpleNonlinearSolveNNlibExt = "NNlib"

    [deps.SimpleNonlinearSolve.weakdeps]
    NNlib = "872c559c-99b0-510c-b3b7-b6c96a88d5cd"

[[deps.SimpleTraits]]
deps = ["InteractiveUtils", "MacroTools"]
git-tree-sha1 = "5d7e3f4e11935503d3ecaf7186eac40602e7d231"
uuid = "699a6c99-e7fa-54fc-8d76-47d257e15c1d"
version = "0.9.4"

[[deps.SimpleUnPack]]
git-tree-sha1 = "58e6353e72cde29b90a69527e56df1b5c3d8c437"
uuid = "ce78b400-467f-4804-87d8-8f486da07d0a"
version = "1.1.0"

[[deps.SnoopPrecompile]]
deps = ["Preferences"]
git-tree-sha1 = "e760a70afdcd461cf01a575947738d359234665c"
uuid = "66db9d55-30c0-4569-8b51-7e840670fc0c"
version = "1.0.3"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"
version = "1.11.0"

[[deps.SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "66e0a8e672a0bdfca2c3f5937efb8538b9ddc085"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.2.1"

[[deps.SparseArrays]]
deps = ["Libdl", "LinearAlgebra", "Random", "Serialization", "SuiteSparse_jll"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
version = "1.11.0"

[[deps.SparseDiffTools]]
deps = ["ADTypes", "Adapt", "ArrayInterface", "Compat", "DataStructures", "FiniteDiff", "ForwardDiff", "Graphs", "LinearAlgebra", "Reexport", "Requires", "SciMLOperators", "Setfield", "SparseArrays", "StaticArrayInterface", "StaticArrays", "Tricks", "VertexSafeGraphs"]
git-tree-sha1 = "4c1a57bcbc0b795fbfdc2009e70f9c2fd2815bfe"
uuid = "47a9eef4-7e08-11e9-0b38-333d64bd3804"
version = "2.4.1"

    [deps.SparseDiffTools.extensions]
    SparseDiffToolsZygoteExt = "Zygote"

    [deps.SparseDiffTools.weakdeps]
    Zygote = "e88e6eb3-aa80-5325-afca-941959d7151f"

[[deps.Sparspak]]
deps = ["Libdl", "LinearAlgebra", "Logging", "OffsetArrays", "Printf", "SparseArrays", "Test"]
git-tree-sha1 = "342cf4b449c299d8d1ceaf00b7a49f4fbc7940e7"
uuid = "e56a9233-b9d6-4f03-8d0f-1825330902ac"
version = "0.3.9"

[[deps.SpecialFunctions]]
deps = ["IrrationalConstants", "LogExpFunctions", "OpenLibm_jll", "OpenSpecFun_jll"]
git-tree-sha1 = "2f5d4697f21388cbe1ff299430dd169ef97d7e14"
uuid = "276daf66-3868-5448-9aa4-cd146d93841b"
version = "2.4.0"
weakdeps = ["ChainRulesCore"]

    [deps.SpecialFunctions.extensions]
    SpecialFunctionsChainRulesCoreExt = "ChainRulesCore"

[[deps.Static]]
deps = ["IfElse"]
git-tree-sha1 = "d2fdac9ff3906e27f7a618d47b676941baa6c80c"
uuid = "aedffcd0-7271-4cad-89d0-dc628f76c6d3"
version = "0.8.10"

[[deps.StaticArrayInterface]]
deps = ["ArrayInterface", "Compat", "IfElse", "LinearAlgebra", "PrecompileTools", "Static"]
git-tree-sha1 = "96381d50f1ce85f2663584c8e886a6ca97e60554"
uuid = "0d7ed370-da01-4f52-bd93-41d350b8b718"
version = "1.8.0"
weakdeps = ["OffsetArrays", "StaticArrays"]

    [deps.StaticArrayInterface.extensions]
    StaticArrayInterfaceOffsetArraysExt = "OffsetArrays"
    StaticArrayInterfaceStaticArraysExt = "StaticArrays"

[[deps.StaticArrays]]
deps = ["LinearAlgebra", "PrecompileTools", "Random", "StaticArraysCore"]
git-tree-sha1 = "eeafab08ae20c62c44c8399ccb9354a04b80db50"
uuid = "90137ffa-7385-5640-81b9-e52037218182"
version = "1.9.7"
weakdeps = ["ChainRulesCore", "Statistics"]

    [deps.StaticArrays.extensions]
    StaticArraysChainRulesCoreExt = "ChainRulesCore"
    StaticArraysStatisticsExt = "Statistics"

[[deps.StaticArraysCore]]
git-tree-sha1 = "192954ef1208c7019899fbf8049e717f92959682"
uuid = "1e83bf80-4336-4d27-bf5d-d5a4f845583c"
version = "1.4.3"

[[deps.Statistics]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "ae3bb1eb3bba077cd276bc5cfc337cc65c3075c0"
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.11.1"
weakdeps = ["SparseArrays"]

    [deps.Statistics.extensions]
    SparseArraysExt = ["SparseArrays"]

[[deps.StatsAPI]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "1ff449ad350c9c4cbc756624d6f8a8c3ef56d3ed"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.7.0"

[[deps.StatsBase]]
deps = ["DataAPI", "DataStructures", "LinearAlgebra", "LogExpFunctions", "Missings", "Printf", "Random", "SortingAlgorithms", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "5cf7606d6cef84b543b483848d4ae08ad9832b21"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.34.3"

[[deps.StatsFuns]]
deps = ["HypergeometricFunctions", "IrrationalConstants", "LogExpFunctions", "Reexport", "Rmath", "SpecialFunctions"]
git-tree-sha1 = "b423576adc27097764a90e163157bcfc9acf0f46"
uuid = "4c63d2b9-4356-54db-8cca-17b64c39e42c"
version = "1.3.2"

    [deps.StatsFuns.extensions]
    StatsFunsChainRulesCoreExt = "ChainRulesCore"
    StatsFunsInverseFunctionsExt = "InverseFunctions"

    [deps.StatsFuns.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    InverseFunctions = "3587e190-3f89-42d0-90ee-14403ec27112"

[[deps.SteadyStateDiffEq]]
deps = ["DiffEqBase", "DiffEqCallbacks", "LinearAlgebra", "NLsolve", "Reexport", "SciMLBase"]
git-tree-sha1 = "2ca69f4be3294e4cd987d83d6019037d420d9fc1"
uuid = "9672c7b4-1e72-59bd-8a11-6ac3964bc41f"
version = "1.16.1"

[[deps.StochasticDiffEq]]
deps = ["Adapt", "ArrayInterface", "DataStructures", "DiffEqBase", "DiffEqNoiseProcess", "DocStringExtensions", "FillArrays", "FiniteDiff", "ForwardDiff", "JumpProcesses", "LevyArea", "LinearAlgebra", "Logging", "MuladdMacro", "NLsolve", "OrdinaryDiffEq", "Random", "RandomNumbers", "RecursiveArrayTools", "Reexport", "SciMLBase", "SciMLOperators", "SparseArrays", "SparseDiffTools", "StaticArrays", "UnPack"]
git-tree-sha1 = "b341540a647b39728b6d64eaeda82178e848f76e"
uuid = "789caeaf-c7a9-5a7d-9973-96adeb23e2a0"
version = "6.62.0"

[[deps.StrideArraysCore]]
deps = ["ArrayInterface", "CloseOpenIntervals", "IfElse", "LayoutPointers", "LinearAlgebra", "ManualMemory", "SIMDTypes", "Static", "StaticArrayInterface", "ThreadingUtilities"]
git-tree-sha1 = "f35f6ab602df8413a50c4a25ca14de821e8605fb"
uuid = "7792a7ef-975c-4747-a70f-980b88e8d1da"
version = "0.5.7"

[[deps.StringManipulation]]
deps = ["PrecompileTools"]
git-tree-sha1 = "a6b1675a536c5ad1a60e5a5153e1fee12eb146e3"
uuid = "892a3eda-7b42-436c-8928-eab12a02cf0e"
version = "0.4.0"

[[deps.StyledStrings]]
uuid = "f489334b-da3d-4c2e-b8f0-e476e12c162b"
version = "1.11.0"

[[deps.SuiteSparse]]
deps = ["Libdl", "LinearAlgebra", "Serialization", "SparseArrays"]
uuid = "4607b0f0-06f3-5cda-b6b1-a6196a1729e9"

[[deps.SuiteSparse_jll]]
deps = ["Artifacts", "Libdl", "libblastrampoline_jll"]
uuid = "bea87d4a-7f5b-5778-9afe-8cc45184846c"
version = "7.7.0+0"

[[deps.Sundials]]
deps = ["CEnum", "DataStructures", "DiffEqBase", "Libdl", "LinearAlgebra", "Logging", "PrecompileTools", "Reexport", "SciMLBase", "SparseArrays", "Sundials_jll"]
git-tree-sha1 = "71dc65a2d7decdde5500299c9b04309e0138d1b4"
uuid = "c3572dad-4567-51f8-b174-8c6c989267f4"
version = "4.20.1"

[[deps.Sundials_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "SuiteSparse_jll", "libblastrampoline_jll"]
git-tree-sha1 = "91db7ed92c66f81435fe880947171f1212936b14"
uuid = "fb77eaff-e24c-56d4-86b1-d163f2edb164"
version = "5.2.3+0"

[[deps.SymbolicIndexingInterface]]
deps = ["DocStringExtensions"]
git-tree-sha1 = "f8ab052bfcbdb9b48fad2c80c873aa0d0344dfe5"
uuid = "2efcf032-c050-4f8e-a9bb-153293bab1f5"
version = "0.2.2"

[[deps.SymbolicUtils]]
deps = ["AbstractTrees", "Bijections", "ChainRulesCore", "Combinatorics", "ConstructionBase", "DataStructures", "DocStringExtensions", "DynamicPolynomials", "IfElse", "LabelledArrays", "LinearAlgebra", "MultivariatePolynomials", "NaNMath", "Setfield", "SparseArrays", "SpecialFunctions", "StaticArrays", "TimerOutputs", "Unityper"]
git-tree-sha1 = "2f3fa844bcd33e40d8c29de5ee8dded7a0a70422"
uuid = "d1185830-fcd6-423d-90d6-eec64667417b"
version = "1.4.0"

[[deps.Symbolics]]
deps = ["ArrayInterface", "Bijections", "ConstructionBase", "DataStructures", "DiffRules", "Distributions", "DocStringExtensions", "DomainSets", "DynamicPolynomials", "Groebner", "IfElse", "LaTeXStrings", "LambertW", "Latexify", "Libdl", "LinearAlgebra", "LogExpFunctions", "MacroTools", "Markdown", "NaNMath", "PrecompileTools", "RecipesBase", "RecursiveArrayTools", "Reexport", "Requires", "RuntimeGeneratedFunctions", "SciMLBase", "Setfield", "SparseArrays", "SpecialFunctions", "StaticArrays", "SymbolicUtils"]
git-tree-sha1 = "28f55dcd865e4a97f262fc476306cee14e8d4651"
uuid = "0c5d862f-8b57-4792-8d23-62f2024744c7"
version = "5.11.0"

    [deps.Symbolics.extensions]
    SymbolicsSymPyExt = "SymPy"

    [deps.Symbolics.weakdeps]
    SymPy = "24249f21-da20-56a4-8eb1-6a02cf4ae2e6"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.TableTraits]]
deps = ["IteratorInterfaceExtensions"]
git-tree-sha1 = "c06b2f539df1c6efa794486abfb6ed2022561a39"
uuid = "3783bdb8-4a98-5b6b-af9a-565f29a5fe9c"
version = "1.0.1"

[[deps.Tables]]
deps = ["DataAPI", "DataValueInterfaces", "IteratorInterfaceExtensions", "OrderedCollections", "TableTraits"]
git-tree-sha1 = "598cd7c1f68d1e205689b1c2fe65a9f85846f297"
uuid = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"
version = "1.12.0"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.0"

[[deps.TensorCore]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "1feb45f88d133a655e001435632f019a9a1bcdb6"
uuid = "62fd8b95-f654-4bbd-a8a5-9c27f68ccd50"
version = "0.1.1"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"
version = "1.11.0"

[[deps.ThreadingUtilities]]
deps = ["ManualMemory"]
git-tree-sha1 = "eda08f7e9818eb53661b3deb74e3159460dfbc27"
uuid = "8290d209-cae3-49c0-8002-c8c24d57dab5"
version = "0.5.2"

[[deps.TimerOutputs]]
deps = ["ExprTools", "Printf"]
git-tree-sha1 = "3a6f063d690135f5c1ba351412c82bae4d1402bf"
uuid = "a759f4b9-e2f1-59dc-863e-4aeb61b1ea8f"
version = "0.5.25"

[[deps.Tokenize]]
git-tree-sha1 = "468b4685af4abe0e9fd4d7bf495a6554a6276e75"
uuid = "0796e94c-ce3b-5d07-9a54-7f471281c624"
version = "0.5.29"

[[deps.TranscodingStreams]]
git-tree-sha1 = "0c45878dcfdcfa8480052b6ab162cdd138781742"
uuid = "3bb67fe8-82b1-5028-8e26-92a6c54297fa"
version = "0.11.3"

[[deps.TriangularSolve]]
deps = ["CloseOpenIntervals", "IfElse", "LayoutPointers", "LinearAlgebra", "LoopVectorization", "Polyester", "Static", "VectorizationBase"]
git-tree-sha1 = "be986ad9dac14888ba338c2554dcfec6939e1393"
uuid = "d5829a12-d9aa-46ab-831f-fb7c9ab06edf"
version = "0.2.1"

[[deps.Tricks]]
git-tree-sha1 = "7822b97e99a1672bfb1b49b668a6d46d58d8cbcb"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.9"

[[deps.TruncatedStacktraces]]
deps = ["InteractiveUtils", "MacroTools", "Preferences"]
git-tree-sha1 = "ea3e54c2bdde39062abf5a9758a23735558705e1"
uuid = "781d530d-4396-4725-bb49-402e4bee1e77"
version = "1.4.0"

[[deps.URIs]]
git-tree-sha1 = "67db6cc7b3821e19ebe75791a9dd19c9b1188f2b"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.5.1"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"
version = "1.11.0"

[[deps.UnPack]]
git-tree-sha1 = "387c1f73762231e86e0c9c5443ce3b4a0a9a0c2b"
uuid = "3a884ed6-31ef-47d7-9d2a-63182c4928ed"
version = "1.0.2"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"
version = "1.11.0"

[[deps.UnicodeFun]]
deps = ["REPL"]
git-tree-sha1 = "53915e50200959667e78a92a418594b428dffddf"
uuid = "1cfade01-22cf-5700-b092-accc4b62d6e1"
version = "0.4.1"

[[deps.Unitful]]
deps = ["Dates", "LinearAlgebra", "Random"]
git-tree-sha1 = "d95fe458f26209c66a187b1114df96fd70839efd"
uuid = "1986cc42-f94f-5a68-af5c-568840ba703d"
version = "1.21.0"

    [deps.Unitful.extensions]
    ConstructionBaseUnitfulExt = "ConstructionBase"
    InverseFunctionsUnitfulExt = "InverseFunctions"

    [deps.Unitful.weakdeps]
    ConstructionBase = "187b0558-2788-49d3-abe0-74a17ed4e7c9"
    InverseFunctions = "3587e190-3f89-42d0-90ee-14403ec27112"

[[deps.UnitfulLatexify]]
deps = ["LaTeXStrings", "Latexify", "Unitful"]
git-tree-sha1 = "975c354fcd5f7e1ddcc1f1a23e6e091d99e99bc8"
uuid = "45397f5d-5981-4c77-b2b3-fc36d6e9b728"
version = "1.6.4"

[[deps.Unityper]]
deps = ["ConstructionBase"]
git-tree-sha1 = "25008b734a03736c41e2a7dc314ecb95bd6bbdb0"
uuid = "a7c27f48-0311-42f6-a7f8-2c11e75eb415"
version = "0.1.6"

[[deps.Unzip]]
git-tree-sha1 = "ca0969166a028236229f63514992fc073799bb78"
uuid = "41fe7b60-77ed-43a1-b4f0-825fd5a5650d"
version = "0.2.0"

[[deps.VectorizationBase]]
deps = ["ArrayInterface", "CPUSummary", "HostCPUFeatures", "IfElse", "LayoutPointers", "Libdl", "LinearAlgebra", "SIMDTypes", "Static", "StaticArrayInterface"]
git-tree-sha1 = "e7f5b81c65eb858bed630fe006837b935518aca5"
uuid = "3d5dd08c-fd9d-11e8-17fa-ed2836048c2f"
version = "0.21.70"

[[deps.VertexSafeGraphs]]
deps = ["Graphs"]
git-tree-sha1 = "8351f8d73d7e880bfc042a8b6922684ebeafb35c"
uuid = "19fa3120-7c27-5ec5-8db8-b0b0aa330d6f"
version = "0.2.0"

[[deps.Vulkan_Loader_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Wayland_jll", "Xorg_libX11_jll", "Xorg_libXrandr_jll", "xkbcommon_jll"]
git-tree-sha1 = "2f0486047a07670caad3a81a075d2e518acc5c59"
uuid = "a44049a8-05dd-5a78-86c9-5fde0876e88c"
version = "1.3.243+0"

[[deps.Wayland_jll]]
deps = ["Artifacts", "EpollShim_jll", "Expat_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "7558e29847e99bc3f04d6569e82d0f5c54460703"
uuid = "a2964d1f-97da-50d4-b82a-358c7fce9d89"
version = "1.21.0+1"

[[deps.Wayland_protocols_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "93f43ab61b16ddfb2fd3bb13b3ce241cafb0e6c9"
uuid = "2381bf8a-dfd0-557d-9999-79630e7b1b91"
version = "1.31.0+0"

[[deps.XML2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libiconv_jll", "Zlib_jll"]
git-tree-sha1 = "1165b0443d0eca63ac1e32b8c0eb69ed2f4f8127"
uuid = "02c8fc9c-b97f-50b9-bbe4-9be30ff0a78a"
version = "2.13.3+0"

[[deps.XSLT_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgcrypt_jll", "Libgpg_error_jll", "Libiconv_jll", "XML2_jll", "Zlib_jll"]
git-tree-sha1 = "a54ee957f4c86b526460a720dbc882fa5edcbefc"
uuid = "aed1982a-8fda-507f-9586-7b0439959a61"
version = "1.1.41+0"

[[deps.XZ_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "ac88fb95ae6447c8dda6a5503f3bafd496ae8632"
uuid = "ffd25f8a-64ca-5728-b0f7-c24cf3aae800"
version = "5.4.6+0"

[[deps.Xorg_libICE_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "326b4fea307b0b39892b3e85fa451692eda8d46c"
uuid = "f67eecfb-183a-506d-b269-f58e52b52d7c"
version = "1.1.1+0"

[[deps.Xorg_libSM_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libICE_jll"]
git-tree-sha1 = "3796722887072218eabafb494a13c963209754ce"
uuid = "c834827a-8449-5923-a945-d239c165b7dd"
version = "1.2.4+0"

[[deps.Xorg_libX11_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxcb_jll", "Xorg_xtrans_jll"]
git-tree-sha1 = "afead5aba5aa507ad5a3bf01f58f82c8d1403495"
uuid = "4f6342f7-b3d2-589e-9d20-edeb45f2b2bc"
version = "1.8.6+0"

[[deps.Xorg_libXau_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "6035850dcc70518ca32f012e46015b9beeda49d8"
uuid = "0c0b7dd1-d40b-584c-a123-a41640f87eec"
version = "1.0.11+0"

[[deps.Xorg_libXcursor_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXfixes_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "12e0eb3bc634fa2080c1c37fccf56f7c22989afd"
uuid = "935fb764-8cf2-53bf-bb30-45bb1f8bf724"
version = "1.2.0+4"

[[deps.Xorg_libXdmcp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "34d526d318358a859d7de23da945578e8e8727b7"
uuid = "a3789734-cfe1-5b06-b2d0-1dd0d9d62d05"
version = "1.1.4+0"

[[deps.Xorg_libXext_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "d2d1a5c49fae4ba39983f63de6afcbea47194e85"
uuid = "1082639a-0dae-5f34-9b06-72781eeb8cb3"
version = "1.3.6+0"

[[deps.Xorg_libXfixes_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "0e0dc7431e7a0587559f9294aeec269471c991a4"
uuid = "d091e8ba-531a-589c-9de9-94069b037ed8"
version = "5.0.3+4"

[[deps.Xorg_libXi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll", "Xorg_libXfixes_jll"]
git-tree-sha1 = "89b52bc2160aadc84d707093930ef0bffa641246"
uuid = "a51aa0fd-4e3c-5386-b890-e753decda492"
version = "1.7.10+4"

[[deps.Xorg_libXinerama_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll"]
git-tree-sha1 = "26be8b1c342929259317d8b9f7b53bf2bb73b123"
uuid = "d1454406-59df-5ea1-beac-c340f2130bc3"
version = "1.1.4+4"

[[deps.Xorg_libXrandr_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "34cea83cb726fb58f325887bf0612c6b3fb17631"
uuid = "ec84b674-ba8e-5d96-8ba1-2a689ba10484"
version = "1.5.2+4"

[[deps.Xorg_libXrender_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "47e45cd78224c53109495b3e324df0c37bb61fbe"
uuid = "ea2f1a96-1ddc-540d-b46f-429655e07cfa"
version = "0.9.11+0"

[[deps.Xorg_libpthread_stubs_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "8fdda4c692503d44d04a0603d9ac0982054635f9"
uuid = "14d82f49-176c-5ed1-bb49-ad3f5cbd8c74"
version = "0.1.1+0"

[[deps.Xorg_libxcb_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "XSLT_jll", "Xorg_libXau_jll", "Xorg_libXdmcp_jll", "Xorg_libpthread_stubs_jll"]
git-tree-sha1 = "bcd466676fef0878338c61e655629fa7bbc69d8e"
uuid = "c7cfdc94-dc32-55de-ac96-5a1b8d977c5b"
version = "1.17.0+0"

[[deps.Xorg_libxkbfile_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "730eeca102434283c50ccf7d1ecdadf521a765a4"
uuid = "cc61e674-0454-545c-8b26-ed2c68acab7a"
version = "1.1.2+0"

[[deps.Xorg_xcb_util_cursor_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_jll", "Xorg_xcb_util_renderutil_jll"]
git-tree-sha1 = "04341cb870f29dcd5e39055f895c39d016e18ccd"
uuid = "e920d4aa-a673-5f3a-b3d7-f755a4d47c43"
version = "0.1.4+0"

[[deps.Xorg_xcb_util_image_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "0fab0a40349ba1cba2c1da699243396ff8e94b97"
uuid = "12413925-8142-5f55-bb0e-6d7ca50bb09b"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxcb_jll"]
git-tree-sha1 = "e7fd7b2881fa2eaa72717420894d3938177862d1"
uuid = "2def613f-5ad1-5310-b15b-b15d46f528f5"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_keysyms_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "d1151e2c45a544f32441a567d1690e701ec89b00"
uuid = "975044d2-76e6-5fbe-bf08-97ce7c6574c7"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_renderutil_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "dfd7a8f38d4613b6a575253b3174dd991ca6183e"
uuid = "0d47668e-0667-5a69-a72c-f761630bfb7e"
version = "0.3.9+1"

[[deps.Xorg_xcb_util_wm_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "e78d10aab01a4a154142c5006ed44fd9e8e31b67"
uuid = "c22f9ab0-d5fe-5066-847c-f4bb1cd4e361"
version = "0.4.1+1"

[[deps.Xorg_xkbcomp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxkbfile_jll"]
git-tree-sha1 = "330f955bc41bb8f5270a369c473fc4a5a4e4d3cb"
uuid = "35661453-b289-5fab-8a00-3d9160c6a3a4"
version = "1.4.6+0"

[[deps.Xorg_xkeyboard_config_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xkbcomp_jll"]
git-tree-sha1 = "691634e5453ad362044e2ad653e79f3ee3bb98c3"
uuid = "33bec58e-1273-512f-9401-5d533626f822"
version = "2.39.0+0"

[[deps.Xorg_xtrans_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "e92a1a012a10506618f10b7047e478403a046c77"
uuid = "c5fb5394-a638-5e4d-96e5-b29de1b5cf10"
version = "1.5.0+0"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.13+1"

[[deps.Zstd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "555d1076590a6cc2fdee2ef1469451f872d8b41b"
uuid = "3161d3a3-bdf6-5164-811a-617609db77b4"
version = "1.5.6+1"

[[deps.ZygoteRules]]
deps = ["ChainRulesCore", "MacroTools"]
git-tree-sha1 = "27798139afc0a2afa7b1824c206d5e87ea587a00"
uuid = "700de1a5-db45-46bc-99cf-38207098b444"
version = "0.2.5"

[[deps.eudev_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "gperf_jll"]
git-tree-sha1 = "431b678a28ebb559d224c0b6b6d01afce87c51ba"
uuid = "35ca27e7-8b34-5b7f-bca9-bdc33f59eb06"
version = "3.2.9+0"

[[deps.fzf_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "936081b536ae4aa65415d869287d43ef3cb576b2"
uuid = "214eeab7-80f7-51ab-84ad-2988db7cef09"
version = "0.53.0+0"

[[deps.gperf_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "3516a5630f741c9eecb3720b1ec9d8edc3ecc033"
uuid = "1a1c6b14-54f6-533d-8383-74cd7377aa70"
version = "3.1.1+0"

[[deps.libaom_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1827acba325fdcdf1d2647fc8d5301dd9ba43a9d"
uuid = "a4ae2306-e953-59d6-aa16-d00cac43593b"
version = "3.9.0+0"

[[deps.libass_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "e17c115d55c5fbb7e52ebedb427a0dca79d4484e"
uuid = "0ac62f75-1d6f-5e53-bd7c-93b484bb37c0"
version = "0.15.2+0"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.11.0+0"

[[deps.libdecor_jll]]
deps = ["Artifacts", "Dbus_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "Pango_jll", "Wayland_jll", "xkbcommon_jll"]
git-tree-sha1 = "9bf7903af251d2050b467f76bdbe57ce541f7f4f"
uuid = "1183f4f0-6f2a-5f1a-908b-139f9cdfea6f"
version = "0.2.2+0"

[[deps.libevdev_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "141fe65dc3efabb0b1d5ba74e91f6ad26f84cc22"
uuid = "2db6ffa8-e38f-5e21-84af-90c45d0032cc"
version = "1.11.0+0"

[[deps.libfdk_aac_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "8a22cf860a7d27e4f3498a0fe0811a7957badb38"
uuid = "f638f0a6-7fb0-5443-88ba-1cc74229b280"
version = "2.0.3+0"

[[deps.libinput_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "eudev_jll", "libevdev_jll", "mtdev_jll"]
git-tree-sha1 = "ad50e5b90f222cfe78aa3d5183a20a12de1322ce"
uuid = "36db933b-70db-51c0-b978-0f229ee0e533"
version = "1.18.0+0"

[[deps.libpng_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "b70c870239dc3d7bc094eb2d6be9b73d27bef280"
uuid = "b53b4c65-9356-5827-b1ea-8c7a1a84506f"
version = "1.6.44+0"

[[deps.libvorbis_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Ogg_jll", "Pkg"]
git-tree-sha1 = "490376214c4721cdaca654041f635213c6165cb3"
uuid = "f27f6e37-5d2b-51aa-960f-b287f2bc3b7a"
version = "1.3.7+2"

[[deps.mtdev_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "814e154bdb7be91d78b6802843f76b6ece642f11"
uuid = "009596ad-96f7-51b1-9f1b-5ce2d5e8a71e"
version = "1.1.6+0"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.59.0+0"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+2"

[[deps.x264_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4fea590b89e6ec504593146bf8b988b2c00922b2"
uuid = "1270edf5-f2f9-52d2-97e9-ab00b5d0237a"
version = "2021.5.5+0"

[[deps.x265_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "ee567a171cce03570d77ad3a43e90218e38937a9"
uuid = "dfaa095f-4041-5dcd-9319-2fabd8486b76"
version = "3.5.0+0"

[[deps.xkbcommon_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Wayland_jll", "Wayland_protocols_jll", "Xorg_libxcb_jll", "Xorg_xkeyboard_config_jll"]
git-tree-sha1 = "9c304562909ab2bab0262639bd4f444d7bc2be37"
uuid = "d8fb68d0-12a3-5cfd-a85a-d49703b185fd"
version = "1.4.1+1"
"""

# ╔═╡ Cell order:
# ╟─2e6401b9-9c89-4b4b-8492-d0a83003579b
# ╟─8ba695de-0650-407c-864a-c394c9c7d3ed
# ╟─0102b1ee-7f41-4400-aef3-c33e18b5b716
# ╟─df36d23e-3760-48c1-8c0c-d52f15e7f520
# ╟─0b0440bf-4f75-47bd-bbd8-315066e79c75
# ╟─279eaa4f-41ca-4168-b492-f36543bb8204
# ╟─00037d0a-8be0-4c75-94bc-23c2c639e6e8
# ╟─64dc539b-b268-43b6-a96e-2c4fa7b48474
# ╟─f5faefd6-f496-40fb-8043-ef6b9d172ae0
# ╟─32b3bc77-c4f4-40ab-a5a9-e035022189ac
# ╟─c70c7a06-d1aa-40a9-902b-4bd4b23a6392
# ╟─2cfd31c4-803a-4880-b2a4-5af6594c0975
# ╟─2170f883-1b01-4d16-907e-49c72118e224
# ╟─7d89a7bd-baba-42c1-af4f-26f74138199a
# ╟─9db950f3-6989-4225-845f-dae93d52a9b9
# ╟─c620fb38-6e3d-4d54-b515-a9a5fc4360e4
# ╟─66ea1e28-b50a-43fc-acf5-9a146b51d505
# ╟─b22fd4f1-ee14-4cb4-aff9-94153f470fe1
# ╟─555aa5d3-9e29-459a-8798-51a576d252b4
# ╟─8c809d92-4edb-40ca-ac80-18b7e8c72fae
# ╟─6c87979a-690a-400b-9ab8-7ef26b829195
# ╟─04c14475-24cd-49c3-8a7b-83a9425664be
# ╟─919bf3e4-6aa0-440b-b76f-34a4812c6752
# ╟─855b8530-861e-427e-b6cc-c1b0283568ca
# ╟─c112e62c-9c38-48dc-8294-42911b02ccc5
# ╟─6c96da07-b5ea-4096-a14c-5cd8f0f47c04
# ╟─532acbb6-e504-4deb-88d5-e001a476af15
# ╟─906a0931-e86f-48f3-be11-eb692639e8cc
# ╟─c374e1bd-ec3d-4cf7-aff1-072d6ba60b27
# ╟─2b91a06c-3803-4877-ac9a-1669fbe58d30
# ╟─e8ca5682-cce0-4b2c-ba18-47f2e38192c7
# ╟─17e34ce6-a1fa-4193-9201-3e61a188b48f
# ╠═87df7c88-7e16-4c50-bd80-df5bfea26ee8
# ╟─9433f4d1-3abf-4dea-8107-1070ee5feb2e
# ╟─c3828c90-0559-4686-9f56-41b5b6d48176
# ╟─2b9e43fd-d00d-40f1-ac98-07d48c53d861
# ╠═ff0c4a06-de7b-4cf2-b920-cd84ac9927ea
# ╠═f8238a6e-1e5e-4629-ac20-2c9cb964c53e
# ╠═3349c942-15a8-4b1e-8b4a-7f5154f48b12
# ╟─df81eb5c-16ef-4bf6-9ad0-2cc899c44cb6
# ╟─a5b38e90-cdbe-442f-a078-dd8598a0a4c2
# ╟─3118e37d-f7bd-488e-ab3a-74e0194d3108
# ╟─48dbf14c-ab77-4e6a-9503-8dc53f5dfba8
# ╟─cf72446a-a512-11ec-2b47-ef706c91c6a0
# ╟─b67ed8c0-8ca7-4928-9ebc-98da513c432f
# ╟─05fe1502-dbac-4e9a-9944-7e5dcb090ae4
# ╟─8673be1a-122a-44e7-a9c7-45d12afb466b
# ╟─c36cfb05-9d05-42f0-87eb-a898b6c66317
# ╠═de338095-9ae6-4baa-bb2b-6a4b17f53e06
# ╟─c8b683ca-9620-428d-98c4-2e5b18ec1720
# ╠═2e76d7b1-b293-410c-9ab3-48bed3c2a388
# ╠═7cb2a5e9-a1a3-438e-a44d-252b7009638d
# ╟─268c3afc-d66f-4419-8cc7-e0bf8ff000a0
# ╠═1c798e63-9a9d-4e27-91a3-a2e0e1e89b75
# ╟─88299113-dc0c-4956-9db8-783c763d957b
# ╠═ec119596-0b9e-467f-b05b-abf77d4d0a62
# ╠═d533c313-2dcd-404d-8740-65294a096954
# ╟─67091261-3b6c-4a94-9a70-86519a1eed76
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
