using System.Linq;

private int N = 4;
private int M = 6;


int num_edg = (N-1)*M+(M-1)*N;
int[] C = new int [N*M];
for(int i=0; i<C.length; i++){
  C[i] = i+1
}

int[][] S = new int [num_edg][2];
for(int j=0; j<M; j++){
  for(int k=1; k<N; k++){
    S[k+(N-1)*j][0] = k+N*j;
    S[k+(N-1)*j][1] = k+N*j+1;
  }
}
d = M*(N-1);
for(int j=1; j<N+1; j++){
  for(int k=1; k<M; k++){
    S[d+k+(M-1)*(j-1)][0] = j+(M-1)*(k-1);
    S[d+k+(M-1)*(j-1)][1] = j+(M-1)*k;
  }
}

int a = C.Max();

Random rnd = new Random();
while(a<1){
  int rndnum = rnd.Next(1, num_edg+1); // creates a number between 1 and num_edge
  int[] edge = S[rndnum];

  int cellA = C[edge[0]];
  int cellB = C[edge[1]];
  if(!(cellA==cellB)){
    int[] auxvec = [cellA, cellB];
    int maxAB = auxvec.Max();
    int idx = C.ToList().IndexOf(maxAB);
    C[idx] = auxvec.Min();
    int cA = edge[0] % N + N*((edge[0]%N)==0);
    int cB = edge[1] % N + N*((edge[1]%N)==0);
    int rA = (edge[0]-1)/N + 1; //faltan floor
    int rB = (edge[1]-1)/N + 1;
    S.RemoveAt(rndnum); // S should be a list to use this method
  }
 a = C.Max();
}

int h = M;
int l = N;

int[][] CEN = new int [num_edg][3]
for(int k=1; k<(num_edg+1); k++){
  edge = S[k];
  cA = edge[0] % N + N*((edge[0]%N)==0);
  cB = edge[1] % N + N*((edge[1]%N)==0);
  rA = (edge[0]-1)/N + 1;
  rB = (edge[1]-1)/N + 1;
  if(Abs(edge[0]-edge[1])){ // x = System.Math.Abs(y)
    CEN[k][0] = cA*l/N;
    CEN[k][1] = (rA-0.5)*h/M;
    CEN[k][2] = 1;
  }
  else{
    CEN[k][0] = (cA-0.5)*l/N;
    CEN[k][1] = rA*h/M;
    CEN[k][2] = 0;
  }
}
