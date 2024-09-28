# STP_p2
_Created for the course "Stack of programming technologies" V. N. Karazin Kharkiv National University_

Ruby 3.3.5 Converter of mathematical expressions to RPN (Reverse Polish Notation).
___

The main executable file Program.rb.

The program converts an ordinary mathematical expression into RPN form.

The program supports input by using command line arguments.

The order and set of operations is stored in the file MathOperations.txt, you can add your own operations or change their priority.
An example of a file structure:
```csv
+ -, × * / %, ^
( [
) ]
```
The file consists of 3 lines: 
1. A character and operation priority string.
2. A string of opening brackets (maximum priority).
3. A line of closing brackets (maximum priority).

The operation priority divides operations into comma-separated ```','``` groups, the group on the left has a low priority and the one on the right has a high priority, each group consists of operator characters separated by a space ```' '```, in the middle of the group the priority of the characters is the same.

The 2nd and 3rd lines do not have priority groups (all elements are located as if in the middle of one group with the highest priority); they contain bracketing characters (double operators for increasing the priority of operations inside), each character is separated by a space ```' '```.

Attention: When changing the contents of a file, be sure to follow this structure, the program does not check the correctness of the structure inside the lines!

# Examples

```ruby
> ruby Program.rb
Converter of mathematical expressions to RPN form by Shkilnyi V. CS31
Enter a mathematical expression:
a + b * c
Result of conversion to RPN:
a b c * +

> ruby Program.rb
Converter of mathematical expressions to RPN form by Shkilnyi V. CS31
Enter a mathematical expression:
( a + b ) * ( c + d )
Result of conversion to RPN:
a b + c d + *

> ruby Program.rb
Converter of mathematical expressions to RPN form by Shkilnyi V. CS31
Enter a mathematical expression:
b * c + a
Result of conversion to RPN:
b c * a +

> ruby Program.rb
Converter of mathematical expressions to RPN form by Shkilnyi V. CS31
Enter a mathematical expression:
( a + t ) * ( b * ( a + c ) ) ^ ( c + d )
Result of conversion to RPN:
a t + b a c + * c d + ^ *

> ruby Program.rb
Converter of mathematical expressions to RPN form by Shkilnyi V. CS31
Enter a mathematical expression:
( a + t ) * ( b * ( a + c ) ) ) ^ ( c + d )
Result of conversion to RPN:
a t + b a c + * c d + ^ *

> ruby Program.rb "( a + t ) * ( b * ( a + c ) ) ^ ( c + d )"
a t + b a c + * c d + ^ *

> ruby Program.rb "b * c + a"
b c * a +

> ruby Program.rb "( a + b ) * ( c + d )"
a b + c d + *

> ruby Program.rb 'a + b * c'
a b c * +

> ruby Program.rb '-2 + 4'
-2 4 +

> ruby Program.rb '3.4+5.9'
3.4 5.9 +

> ruby Program.rb '3+-5+'  
3 -5 +

> ruby Program.rb '1/0'  
ERROR! Invalid input. Check that the input is correct! Division by 0 has been detected!

> ruby Program.rb
Converter of mathematical expressions to RPN form by Shkilnyi V. CS31
Enter a mathematical expression:
3 + 4 * 2 / ( 1 - 5 ) ^ 2
Result of conversion to RPN:
3 4 2 * 1 5 - 2 ^ / +

> ruby Program.rb '3 + 4 * 2 / ( 1 - 5 ) ^ 2'
3 4 2 * 1 5 - 2 ^ / +
```