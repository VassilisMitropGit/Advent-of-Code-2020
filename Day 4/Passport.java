import java.util.ArrayList;
import java.util.List;

public class Passport {
    String byr, iyr, eyr, hgt, hcl, ecl, pid, cid;
    List<String> hgtInfo = new ArrayList<String>();

    public void main(){
    }

    public Passport(String byrData, String iyrData, String eyrData, String hgtData, String hclData, String eclData, String pidData, String cidData){
        byr = byrData;
        iyr = iyrData;
        eyr = eyrData;
        hgt = hgtData;
        if (!(hgt == null)){
            String metricSystem = hgt.substring(Math.max(hgt.length() - 2, 0));
            if (metricSystem.equals("cm") || metricSystem.equals("in")){
                String[] height = hgt.split(metricSystem);
                hgtInfo.add(metricSystem);
                if (!height[0].equals(null)){
                    hgtInfo.add(height[0]);
                }
            }
        }
        hcl = hclData;
        ecl = eclData;
        pid = pidData;
        cid = cidData;
    }

    public boolean checkValidity(){
        if (byr == null || byr.length() != 4 || Integer.parseInt(byr) < 1920 || Integer.parseInt(byr) > 2002){
            return false;
        }
        if (iyr == null || iyr.length() != 4 || Integer.parseInt(iyr) < 2010 || Integer.parseInt(iyr) > 2020){
            return false;
        }
        if (eyr == null || eyr.length() != 4 || Integer.parseInt(eyr) < 2020 || Integer.parseInt(eyr) > 2030){
            return false;
        }
        if (hgt == null || hgtInfo.size() == 0 || hgtInfo.size() == 1){
            return false;
        } else if (
            !((hgtInfo.get(0).equals("cm") && Integer.parseInt(hgtInfo.get(1)) >= 150 && Integer.parseInt(hgtInfo.get(1)) <= 193) ||
            (hgtInfo.get(0).equals("in") && Integer.parseInt(hgtInfo.get(1)) >= 59 && Integer.parseInt(hgtInfo.get(1)) <= 76)
        )){
            return false;
        }
        if (hcl == null){
            return false;
        } else if (hcl.substring(0, 1).equals("#")){
            if (hcl.length() != 7){
                return false;
            }
            if (hcl.matches("[a-f0-9]+")){
                return false;
            }
        } else if (!hcl.substring(0, 1).equals("#")){
            return false;
        }
        if (ecl == null || !(ecl.matches("\\bamb|blu|brn|gry|grn|hzl|oth\\b"))){
            return false;
        }
        if (pid == null ){
            return false;
        } else if (pid.length() != 9 || !pid.matches("\\d+")){
            return false;
        }
        return true;
    }
}