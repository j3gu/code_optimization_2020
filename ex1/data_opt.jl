using DelimitedFiles
using  Plots; pyplot()
nopt=zeros(20,2)
opt = zeros(20,2)

open("no_opt.txt") do io
    global nopt
    nopt=readdlm(io, Float64)
end

open("opt1.txt") do io
    global opt
    opt=readdlm(io, Float64)
end
x=collect(1:1:20)
plot(x, opt[:,2], xlabel="stride", ylabel="Bandwidth MB/s",color=:red, marker=:circ, label="Optimization")
plot!(x, nopt[:,2], color=:blue, marker=:plus, label="No optimization" )
