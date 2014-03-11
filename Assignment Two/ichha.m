%Generate 2 Vectors f and g

F = (rand(10000,1)-0.5);
G = (rand(10000,1)-0.5);
Stats = [mean(F) mean(G)]


F= F/norm(F);
G= G/norm(G);


% A is the outer product 
A= G*F';



Gprime= A*F;
Gprime = Gprime/norm(Gprime);

theta1= dot(G,Gprime)
sizeG=length(norm(Gprime))


% 2. 

fprime=(rand(10000,1)-0.5);
fprime= fprime/norm(fprime);
theta =dot(F,fprime)
Afprime = A*fprime;
L=length(norm(Afprime))

% 3. store many vector associations (50)
A2 = [];
Fall =[];
Gall = [];

for i=1:50
  Fi = (rand(50,1)-0.5);
  Gi = (rand(50,1)-0.5);  
  Fi = Fi/norm(Fi);
  Gi =Gi/norm(Gi);
  Fall(i,:) = Fi;
  %Fall(:,i) = Fi;
  Gall(i,:) = Gi;
  
  Ai= Gi*Fi'; 
  A2(i,:) = sum(Ai);
 
end
  % Check to see if the matrix created is orthogonal to Fall and Gall 
 GallPrime = A2*Fall;
 GallPrime = GallPrime / norm(GallPrime);
 theta4 = dot(Gall, GallPrime);
 cosine = acosd(theta4)
 Length = length(GallPrime)
    
  
%New set of random vectors to test selectivity 
  
  
  for i=1:50
  Fnew = (rand(50,1)-0.5);
  Gnew = (rand(50,1)-0.5);  
  Fnew = Fnew/norm(Fnew);
  Gnew =Gnew/norm(Gnew);
  fnewall(i,:) = Fnew;
  gnewall(i,:)=Gnew;
  end
  
  gnewprime =A2*fnewall;
  gnewprime = gnewprime /norm(gnewprime);
  theta5 = dot(gnewprime, gnewall);
  cosine2 = acosd(theta5)
  
  %Repeat for different numbers of pairs of stored vectors 
 
  Pair = [1, 20, 40, 60, 80, 100];
  for idx =1:Pair
      p=Pair(idx);
      for i=1:100
          Fi = (rand(p,1)-0.5);
          Gi = (rand(p,1)-0.5);  
          Fi = Fi/norm(Fi);
          Gi =Gi/norm(Gi);
          for j=1:p
          Ftest(i,:) = Fi;
          Gtest(i,:) = Gi;
  
          Ai= Gi*Fi'; 
          A3(i,:) = sum(Ai)
         
          end
      end
  end
 
 
 
 
  
  