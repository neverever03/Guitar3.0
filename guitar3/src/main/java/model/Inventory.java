package model;

import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;

public class Inventory {
  private List guitars;

  public Inventory(List guitars) {
    this.guitars = guitars;
  }
  public List search(GuitarSpec searchSpec) {
    List matchingGuitars = new LinkedList();
    for (Iterator i = guitars.iterator(); i.hasNext(); ) {
      Guitar guitar = (Guitar)i.next();
      if (guitar.getSpec().matches(searchSpec))
        matchingGuitars.add(guitar);
    }
    return matchingGuitars;
  }
}
