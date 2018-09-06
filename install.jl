using Pkg
Pkg.activate(".")
Pkg.add("IJulia")
Pkg.add("DifferentialEquations")
Pkg.add("Plots")
Pkg.add("Interact")
Pkg.add("Mux")
Pkg.add("Blink")
Pkg.add(PackageSpec(name="GenericSVD",rev="master"));
Pkg.add("PyCall")
Pkg.add("ForwardDiff")
