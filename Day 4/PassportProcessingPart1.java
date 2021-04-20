import java.io.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

public class PassportProcessingPart1{
    public static int validPassports = 0;
    public static void main(String args[]){
        try{
            //the file to be opened for reading
            FileInputStream fis = new FileInputStream("./Day 4/PassportProcessing.txt");
            //file to be scanned
            Scanner sc = new Scanner(fis);
            List<String> tempArray = new ArrayList<String>();
            //returns true if there is another line to read
            while(sc.hasNextLine()){
                String tempLine = sc.nextLine();
                if(tempLine.isEmpty()){
                    createAndValidatePassport(tempArray);
                    tempArray = new ArrayList<String>();
                }else{
                    tempArray.add(tempLine);
                }
            }
            createAndValidatePassport(tempArray);
            //closes the scanner
            sc.close();

            System.out.println(validPassports);
        }
        catch(IOException e){
            e.printStackTrace();
        }
    }

    public static void createAndValidatePassport(List<String> tempArray) {
        String byr, iyr, eyr, hgt, hcl, ecl, pid, cid;
        byr = iyr = eyr = hgt = hcl = ecl = pid = cid = null;
        for (String info : tempArray) {
            String[] fixedInfo = info.split("[ ]");
            for (String entry : fixedInfo) {
                String[] fixedEntry = entry.split(":");
                switch(fixedEntry[0]){
                    case "byr":
                        byr = fixedEntry[1];
                        break;
                    case "iyr":
                        iyr = fixedEntry[1];
                        break;
                    case "eyr":
                        eyr = fixedEntry[1];
                        break;
                    case "hgt":
                        hgt = fixedEntry[1];
                        break;
                    case "hcl":
                        hcl = fixedEntry[1];
                        break;
                    case "ecl":
                        ecl = fixedEntry[1];
                        break;
                    case "pid":
                        pid = fixedEntry[1];
                        break;
                    case "cid":
                        cid = fixedEntry[1];
                        break;
                }
            }
        }

        Passport samplePassport = new Passport(byr, iyr, eyr, hgt, hcl, ecl, pid, cid);

        if (samplePassport.checkValidity()){
            validPassports++;
        }
    }
}