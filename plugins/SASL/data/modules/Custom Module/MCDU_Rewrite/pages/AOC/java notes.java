//import java.math
//Sorting notes in Java
class obese {
    public static void main(String [] args) {
        int [] arr = new int[8];
        arr[0]=3;
        arr[1]=23;
        arr[2]=7;
        arr[3]=96;
        arr[4]=34;
        arr[5]=54;
        arr[6]=23;
        arr[7]=86;



        // for (int i=0; i<arr.length; i++)
        //     arr[i] = (int)(Math.random()*100);
        
        for (int i=0;i<arr.length;i++)
            System.out.print(arr[i]+" ");

        System.out.println(); // adds the new line

        //Swap
        int temp;

        for (int i = 0;i<arr.length;i++) {
            for (int j = 0; j<arr.length;j++) {
                if (arr[j] > arr[j+1]) { // only swapping if first item is greater than second item
                    temp = arr[j];
                    arr[j] = arr[j+1];
                    arr[j+1] = temp; 
                }
            }
        }

        for (int i=0;i<arr.length;i++)
            System.out.print(arr[i]+" ");

        System.out.println(); // adds the new line


    }
}