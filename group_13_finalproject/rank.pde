
public class Rank_data {
  int rank, score;
  //String state;
  
  public Rank_data(){
    rank = 0;
    score = 0;
    //state = "";
  }
}

public class Ranking {
  ArrayList<Rank_data> r_datas = new ArrayList<Rank_data>();  //store the datas in the csv file.
  
  public Ranking(){}
  
  public void load_data(){
    Table table = loadTable("ranking.csv", "header");
    for (TableRow row : table.rows()) {
      Rank_data temp = new Rank_data();
      int rank = row.getInt("rank");
      temp.rank = rank;
      int score = row.getInt("score");
      temp.score = score;
      r_datas.add(temp);
      
      //println(conc + " (" + rate + ") has an state of " + state);
    }
  }
  
  public void print_data(){
    for(int i = 0; i < r_datas.size(); i++){
      Rank_data temp = r_datas.get(i);
      println(temp.rank + ". " + temp.score + " scores");
    }
  }
}