#include <iostream>
#include <cstdlib>
#include <vector>
#include "rappture.h"
#include <boost/lexical_cast.hpp>

//#define N_MAX 101         // Array size
//#define D_DIV 10.         // Scale

int main( int argc, char **argv)
{
  RpLibrary* lib	= NULL;
  const char* data	= NULL;
  char line[100];

  double a = 0;
  double n = 0;
  std::vector<double> x, y;
  double pts = 100;
  double s = 10;

  int err = 0;

  // Check input.
  
  lib = rpLibrary(argv[1]);

  if (lib == NULL) {
	printf("FAILED creating Rappture Library\n");
	return(1);
  } 
  
  rpGetString(lib,"input.integer(points).current",&data);
  pts = rpConvertDbl(data, "points", &err);
  if (err) {
 	printf ("Error while retrieving input.number(points).current\n");	 return(2);
  }


  rpGetString(lib,"input.number(a).current",&data);
  a = rpConvertDbl(data, "coefficient", &err);
  if (err) {
	printf ("Error while retrieving input.number(a).current\n");
	return(3);
  }
 
  rpGetString(lib,"input.number(n).current",&data);
  n = rpConvertDbl(data, "factor", &err);
  if (err) {
	printf ("Error while retrieving input.number(n).current\n");
	return(4);
  }

  rpGetString(lib,"input.number(scale).current",&data);
  s = rpConvertDbl(data, "scale", &err);
  if (err) {
        printf ("Error while retrieving input.number(scale).current\n");
        return(5);
  }


  // Create the x vector.

  for( size_t i = 0; i <= pts; i++ )
  {
    x.push_back( boost::lexical_cast<double>( i ) * s / pts );
  }

  // Compute the y vector.

  for( size_t i = 0; i <= pts; i++ )
  {
    y.push_back(
      boost::lexical_cast<double>( a  ) *
      pow( x[i], boost::lexical_cast<double>( n ) )
    );
    sprintf(line,"%f %f\n",x[i],y[i]);
    rpPutString(lib,"output.curve(xy).component.xy",line,RPLIB_APPEND);
  }

  // Output the vectors.
 
 // for( size_t i = 0; i < N_MAX; i++ )
 // {
 //  std::cout << x[i] << "  " << y[i] << std::endl; 
 // }
  rpResult(lib);
  return EXIT_SUCCESS;

}

