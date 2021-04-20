public class Passport {
    String byr, iyr, eyr, hgt, hcl, ecl, pid, cid;

    public void main(){
    }

    public Passport(String byrData, String iyrData, String eyrData, String hgtData, String hclData, String eclData, String pidData, String cidData){
        byr = byrData;
        iyr = iyrData;
        eyr = eyrData;
        hgt = hgtData;
        hcl = hclData;
        ecl = eclData;
        pid = pidData;
        cid = cidData;
    }

    public boolean checkValidity(){
        if (byr == null || iyr == null || eyr == null || hgt == null || hcl == null || ecl == null || pid == null){
            return false;
        } else{
            return true;
        }
    }
}