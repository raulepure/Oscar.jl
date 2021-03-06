@testset "algebra homomorphisms" begin
  r, (x, y, z) = PolynomialRing(QQ, ["x", "y", "z"])
  s, (a, b, c) = PolynomialRing(QQ, ["a", "b", "c"])
  S = quo(s, ideal(s, [c-b^3]))[1]
  V = S.([2*a+b^6, 7*b-a^2, c^2])
  f = hom(r, S, V)
  K = kernel(f)
  R = quo(r, K)[1]
  phi = hom(R, S, V)
  psi = inverse(phi)
  W = psi.image
  prphi = preimage(phi, S(a))
  prpsi = preimage(psi, R(x))

  @test issurjective(f) == true
  @test isinjective(f) == false
  @test isbijective(f) == false
  @test isfinite(f) == true
  @test issurjective(phi) == true
  @test isinjective(phi) == true
  @test isbijective(phi) == true
  @test isfinite(phi) == true
  @test prphi[1] == R(1//2 * x-1//2*z)
  @test prpsi[1] == S(2*a+c^2)
  @test W[1] == R(1//2 * x-1//2*z)
  @test W[2] == R(1//28*x^2 - 1//14*x*z + 1//7*y + 1//28*z^2)
  @test W[3] == R(1//21952*x^6 - 3//10976*x^5*z + 3//5488*x^4*y + 15//21952*x^4*z^2 - 3//1372*x^3*y*z - 5//5488*x^3*z^3 + 3//1372*x^2*y^2 + 9//2744*x^2*y*z^2 + 15//21952*x^2*z^4 - 3//686*x*y^2*z - 3//1372*x*y*z^3 - 3//10976*x*z^5 + 1//343*y^3 + 3//1372*y^2*z^2 + 3//5488*y*z^4 + 1//21952*z^6)
end

@testset "subalgebra membership" begin
  s, (a, b, c) = PolynomialRing(QQ, ["a", "b", "c"])
  S = quo(s, ideal(s, [c-b^3]))[1]
  t = subalgebra_membership(S(c+a^2-b^6), S.([a,b^3]))
  T = parent(t[2])
  @test t[1] == true
  @test t[2] == gen(T, 1)^2-gen(T, 2)^2+gen(T, 2) 
end