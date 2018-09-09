/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
//import org.json.JSONObject;
import edu.stanford.nlp.tagger.maxent.MaxentTagger;
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.StringTokenizer;
import javapackage.ObjectNode;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author mansi
 */
public class MyServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter())
        {
            MaxentTagger tagger = new MaxentTagger("taggers/english-left3words-distsim.tagger");
       ArrayList<ObjectNode> objects= new ArrayList<ObjectNode>();
       ArrayList<ObjectNode> spobjects= new ArrayList<ObjectNode>();
       ArrayList<ObjectNode> leftobjects= new ArrayList<ObjectNode>();
        String sample=request.getParameter("text");
        String tagged = tagger.tagString(sample);
        tagged=tagged.replace("_"," ");
        tagged=tagged.replace(",","");
        StringTokenizer str = new StringTokenizer(tagged, " ");
        int length = str.countTokens();
        String[] input = new String[length];
        for(int i=0;i<length;i++)
        {
            input[i]=str.nextToken();
            System.out.print(input[i]);
        }
      for(int i=0;i<length;i++)
      {
    	  if(input[i].equals("NN")||input[i].equals("NNS"))
    	  {
              if(input[i-1].equals("front")||input[i-1].equals("top")||input[i-1].equals("left")||input[i-1].equals("right")||input[i-1].equals("back")||input[i-1].equals("bottom"))
              continue;
              else
              {
                  if(input[i-2].equals("JJ")&&input[i-4].equals("CD"))
    			  objects.add(new ObjectNode(input[i-1],input[i-3],input[i-5],i-1));
    		  else if(input[i-2].equals("JJ"))
    			  objects.add(new ObjectNode(input[i-1],input[i-3],"1",i-1));
    		  else if(input[i-2].equals("CD"))
    			  objects.add(new ObjectNode(input[i-1],"black",input[i-3],i-1));
    		  else
    		      objects.add(new ObjectNode(input[i-1],"black","1",i-1));
              }
    	  }
    	 
      }
      for(int i=0;i<objects.size()-1;i++)
        {
           for(int j=i+1;j<objects.size();j++)
           {
               if(objects.get(i).Name.equals(objects.get(j).Name))
               { objects.get(j).pos=objects.get(i).pos;
                 while(j<objects.size()-1)
                 {
                     objects.get(j).Name=objects.get(j+1).Name;
                     objects.get(j).Type=objects.get(j+1).Type;
                     objects.get(j).Number=objects.get(j+1).Number;
                     objects.get(j).pos=objects.get(j+1).pos;
                            j++;
                 }
                 objects.remove(j);
                 
               }
           }
        }
     /* Iterator itr=objects.iterator();  
      //traversing elements of ArrayList object  
      while(itr.hasNext())
      {  
        ObjectNode ob=(ObjectNode)itr.next(); 
        System.out.println(ob.Name+" "+ob.Type+" "+ob.Number);  
      }*/
      /*for(ObjectNode ob:objects)
    	  System.out.println(ob.Name+" "+ob.Type+" "+ob.Number);*/
      System.out.println(objects.size());
     /* BufferedWriter writer= new BufferedWriter(new FileWriter("C:\\Users\\mansi\\Desktop\\ex.txt"));
      writer.write(objects.get(1).Name);
      writer.newLine();
      writer.close();*/
      for(int i=0;i<objects.size();i++)
    	  System.out.println(objects.get(i).Name+" "+objects.get(i).Type+" "+objects.get(i).Number+" "+objects.get(i).pos); 
    for(int i=0;i<length;i++)
    {
        String item1="",item2="";
        int count=0,counter=0;
        if(input[i].equals("IN")||input[i].equals("TO"))
        {
            if((input[i-1].equals("on")||input[i-1].equals("in")||input[i-1].equals("at"))&&input[i-1]!="with")
            {
              if(input[i+1].equals("front")||input[i+1].equals("top")||input[i+1].equals("left")||input[i+1].equals("right")||input[i+1].equals("back")||input[i+1].equals("bottom"))
              {
                  for(int k=i+3;k<length;k++)
                  {
                      if(input[k].equals("NN")||input[k].equals("NNS"))
                      { item2=input[k-1];
                          break;
                      }
                      else if(input[k].equals("PRP"))
                      {
                          for(int j=k;j>0;j--)
                          {
                              if(input[j].equals("NN")||input[j].equals("NNS"))
                              {
                                  if(input[j-1].equals("room"))
                                  {
                                   continue;
                                  }
                                  else
                                  {
                                      item2=input[j-1];
                                 // System.out.println(item2);
                                  count++;}
                                  if(count==3)
                                      break;
                              }
                          }
                      }
                     else if(input[k].equals("WDT"))
                     {
                        counter++;
                     }
                  }
                 for(int k=i-2;k>0;k--)
                  {
                      if(input[k].equals("NN")||input[k].equals("NNS"))
                      { 
                        
                        item1=input[k-1]; 
                        if(input[k-1].equals("front")||input[k-1].equals("top")||input[k-1].equals("left")||input[k-1].equals("left")||input[k-1].equals("right")||input[k-1].equals("back")||input[k-1].equals("bottom")||input[k-1].equals("room"))
                          continue;
                        else
                             break;
                      }
                  } 
                  if(counter==1) 
                  {
                   System.out.println(item2+" "+input[i+1]+" "+item1);
                 for(int m=0;m<objects.size();m++)
                 {
                     if(item2.equals(objects.get(m).Name))
                     {
                      spobjects.add(new ObjectNode(objects.get(m).Name, objects.get(m).Type,objects.get(m).Number,objects.get(m).pos));
                     }
                     }
                 spobjects.add(new ObjectNode(input[i+1]));
                 for(int m=0;m<objects.size();m++)
                 {
                     if(item1.equals(objects.get(m).Name))
                     spobjects.add(new ObjectNode(objects.get(m).Name, objects.get(m).Type,objects.get(m).Number,objects.get(m).pos));
                 } }   
                 else
                 {
                 System.out.println(item1+" "+input[i+1]+" "+item2);
                 for(int m=0;m<objects.size();m++)
                 {
                     if(item1.equals(objects.get(m).Name))
                      spobjects.add(new ObjectNode(objects.get(m).Name, objects.get(m).Type,objects.get(m).Number,objects.get(m).pos));
                 }
                 spobjects.add(new ObjectNode(input[i+1]));
                 for(int m=0;m<objects.size();m++)
                 {
                     if(item2.equals(objects.get(m).Name))
                     spobjects.add(new ObjectNode(objects.get(m).Name, objects.get(m).Type,objects.get(m).Number,objects.get(m).pos));
                 } 
                 }
                  counter=0;
              }
                 else if(input[i+3].equals("front")||input[i+3].equals("top")||input[i+3].equals("left")||input[i+3].equals("right")||input[i+3].equals("back")||input[i+3].equals("bottom"))
              {
                  for(int k=i+5;k<length;k++)
                  {
                      if(input[k].equals("NN")||input[k].equals("NNS"))
                      { item2=input[k-1];
                          break;
                      }
                      else if(input[k].equals("PRP"))
                      {
                          for(int j=k;j>0;j--)
                          {
                              if(input[j].equals("NN")||input[j].equals("NNS"))
                              {
                                   if(input[j-1].equals("room"))
                                   {
                                       continue;
                                  }
                                  else
                                  {
                                  item2=input[j-1];
                                 // System.out.println(item2);
                                  count++;}
                                  if(count==3)
                                      break;
                              }
                          }
                      }
                       else if(input[k].equals("WDT"))
                     {
                        counter++;
                     }
                  }
                 for(int k=i-2;k>0;k--)
                  {
                      if(input[k].equals("NN")||input[k].equals("NNS"))
                      { 
                        item1=input[k-1];
                        if(input[k-1].equals("room"))
                            continue;
                        else
                             break;
                      }
                  } 
                  if(counter==1) 
                  {
                   System.out.println(item2+" "+input[i+3]+" "+item1);
                 for(int m=0;m<objects.size();m++)
                 {
                     if(item2.equals(objects.get(m).Name))
                      spobjects.add(new ObjectNode(objects.get(m).Name, objects.get(m).Type,objects.get(m).Number,objects.get(m).pos));
                 }
                 spobjects.add(new ObjectNode(input[i+3]));
                 for(int m=0;m<objects.size();m++)
                 {
                     if(item1.equals(objects.get(m).Name))
                     spobjects.add(new ObjectNode(objects.get(m).Name, objects.get(m).Type,objects.get(m).Number,objects.get(m).pos));
                 } }   
                 else
                 {
                  System.out.println(item1+" "+input[i+3]+" "+item2);
                  for(int m=0;m<objects.size();m++)
                 {
                     if(item1.equals(objects.get(m).Name))
                      spobjects.add(new ObjectNode(objects.get(m).Name, objects.get(m).Type,objects.get(m).Number,objects.get(m).pos));
                 }
                 spobjects.add(new ObjectNode(input[i+3]));
                 for(int m=0;m<objects.size();m++)
                 {
                     if(item2.equals(objects.get(m).Name))
                     spobjects.add(new ObjectNode(objects.get(m).Name, objects.get(m).Type,objects.get(m).Number,objects.get(m).pos));
                 } 
              }
                  counter=0;
              }
              /*else if()
              {
                  
              }*/
              else
              {
                  for(int k=i+2;k<length;k++)
                  {
                      if(input[k].equals("NN")||input[k].equals("NNS"))
                      { item2=input[k-1];
                          break;
                      }
                      else if(input[k].equals("PRP"))
                      {
                          for(int j=k;j>0;j--)
                          {
                              if(input[j].equals("NN")||input[j].equals("NNS"))
                              { 
                                  if(input[j-1].equals("room"))
                                  {
                                  continue;
                                  }
                                  else
                                  {
                                  item2=input[j-1];
                                  count++;}
                                  if(count==2)
                                  break;
                              }
                          }
                      }
                       else if(input[k].equals("WDT"))
                     {
                        counter++;
                     }
                  }
                 for(int k=i-2;k>0;k--)
                  {
                      if(input[k].equals("NN")||input[k].equals("NNS"))
                      { 
                        item1=input[k-1];
                        if(input[k-1].equals("room"))
                            continue;
                        else
                             break;
                      }
                  } 
                  if(counter==1) 
                  {
                   System.out.println(item2+" "+input[i-1]+" "+item1);
                 for(int m=0;m<objects.size();m++)
                 {
                     if(item2.equals(objects.get(m).Name))
                      spobjects.add(new ObjectNode(objects.get(m).Name, objects.get(m).Type,objects.get(m).Number,objects.get(m).pos));
                 }
                 spobjects.add(new ObjectNode(input[i-1]));
                 for(int m=0;m<objects.size();m++)
                 {
                     if(item1.equals(objects.get(m).Name))
                     spobjects.add(new ObjectNode(objects.get(m).Name, objects.get(m).Type,objects.get(m).Number,objects.get(m).pos));
                 } }   
                 else
                 {
                  System.out.println(item1+" "+input[i-1]+" "+item2);
                  for(int m=0;m<objects.size();m++)
                 {
                     if(item1.equals(objects.get(m).Name))
                      spobjects.add(new ObjectNode(objects.get(m).Name, objects.get(m).Type,objects.get(m).Number,objects.get(m).pos));
                 }
                 spobjects.add(new ObjectNode(input[i-1]));
                 for(int m=0;m<objects.size();m++)
                 {
                     if(item2.equals(objects.get(m).Name))
                     spobjects.add(new ObjectNode(objects.get(m).Name, objects.get(m).Type,objects.get(m).Number,objects.get(m).pos));
                 } 
              }
              count=0;
              counter=0;
            }
            }
            else if(input[i-1].equals("to"))
            {
             if(input[i-2].equals("JJ"))
             {
                 for(int k=i+1;k<length;k++)
                  {
                      if(input[k].equals("NN")||input[k].equals("NNS"))
                      { item2=input[k-1];
                          break;
                      }
                      else if(input[k].equals("PRP"))
                      {
                          for(int j=k;j>0;j--)
                          {
                              if(input[j].equals("NN")||input[j].equals("NNS"))
                              {
                                  if(input[j-1].equals("room"))
                                  {
                                  continue;
                                  }
                                  else
                                  {
                                  item2=input[j-1];
                                 // System.out.println(item2);
                                  count++;
                                  }
                                  if(count==2)
                                      break;
                              }
                          }
                      }
                       else if(input[k].equals("WDT"))
                     {
                        counter++;
                     }
                  }
                 for(int k=i-1;k>0;k--)
                  {
                      if(input[k].equals("NN")||input[k].equals("NNS"))
                      { 
                        item1=input[k-1]; 
                        if(input[k-1].equals("room"))
                            continue;
                        else
                             break;
                      }
                  } 
                  if(counter==1) 
                  {
                   System.out.println(item2+" "+input[i-3]+" "+item1);
                 for(int m=0;m<objects.size();m++)
                 {
                     if(item2.equals(objects.get(m).Name))
                      spobjects.add(new ObjectNode(objects.get(m).Name, objects.get(m).Type,objects.get(m).Number,objects.get(m).pos));
                 }
                 spobjects.add(new ObjectNode(input[i-3]));
                 for(int m=0;m<objects.size();m++)
                 {
                     if(item1.equals(objects.get(m).Name))
                     spobjects.add(new ObjectNode(objects.get(m).Name, objects.get(m).Type,objects.get(m).Number,objects.get(m).pos));
                 } }   
                 else
                 {
                  System.out.println(item1+" "+input[i-3]+" "+item2);
                  for(int m=0;m<objects.size();m++)
                 {
                     if(item1.equals(objects.get(m).Name))
                      spobjects.add(new ObjectNode(objects.get(m).Name, objects.get(m).Type,objects.get(m).Number,objects.get(m).pos));
                 }
                 spobjects.add(new ObjectNode(input[i-3]));
                 for(int m=0;m<objects.size();m++)
                 {
                     if(item2.equals(objects.get(m).Name))
                     spobjects.add(new ObjectNode(objects.get(m).Name, objects.get(m).Type,objects.get(m).Number,objects.get(m).pos));
                 } 
            }
                  counter=0;
             }
            }
            else if(input[i-1].equals("with")||input[i-1].equals("of"))
            {
             continue;   
            }
            else 
            {     
                  for(int k=i+1;k<length;k++)
                  {
                      if(input[k].equals("NN")||input[k].equals("NNS"))
                      { item2=input[k-1];
                          break;
                      }
                      else if(input[k].equals("PRP"))
                      {
                          for(int j=k;j>0;j--)
                          {
                              if(input[j].equals("NN")||input[j].equals("NNS"))
                              {
                                  item2=input[j-1];
                                 // System.out.println(item2);
                                  count++;
                                  if(count==2)
                                      break;
                              }
                          }
                      }
                       else if(input[k].equals("WDT"))
                     {
                        counter++;
                     }
                  }
                 for(int k=i-1;k>0;k--)
                  {
                      if(input[k].equals("NN")||input[k].equals("NNS"))
                      { 
                        item1=input[k-1]; 
                        if(input[k-1].equals("room"))
                            continue;
                        else
                             break;
                      }
                  } 
                  if(counter==1) 
                  {
                   System.out.println(item2+" "+input[i-1]+" "+item1);
                 for(int m=0;m<objects.size();m++)
                 {
                     if(item2.equals(objects.get(m).Name))
                      spobjects.add(new ObjectNode(objects.get(m).Name, objects.get(m).Type,objects.get(m).Number,objects.get(m).pos));
                 }
                 spobjects.add(new ObjectNode(input[i-1]));
                 for(int m=0;m<objects.size();m++)
                 {
                     if(item1.equals(objects.get(m).Name))
                     spobjects.add(new ObjectNode(objects.get(m).Name, objects.get(m).Type,objects.get(m).Number,objects.get(m).pos));
                 } }   
                 else
                 {
                  System.out.println(item1+" "+input[i-1]+" "+item2);
                  for(int m=0;m<objects.size();m++)
                 {
                     if(item1.equals(objects.get(m).Name))
                      spobjects.add(new ObjectNode(objects.get(m).Name, objects.get(m).Type,objects.get(m).Number,objects.get(m).pos));
                 }
                 spobjects.add(new ObjectNode(input[i-1]));
                 for(int m=0;m<objects.size();m++)
                 {
                     if(item2.equals(objects.get(m).Name))
                     spobjects.add(new ObjectNode(objects.get(m).Name, objects.get(m).Type,objects.get(m).Number,objects.get(m).pos));
                 } 
            }
                  counter=0;
            }
           /* else if(input[i-1].equals("with"))
            {
                
            }*/
        }
    }
    int count1=0;
    /*for(int i=0;i<spobjects.size();i++)
    System.out.println(spobjects.get(i).Name+" "+spobjects.get(i).Number+" "+spobjects.get(i).Type+" "+spobjects.get(i).pos);*/
    for(int i=0;i<objects.size();i++)
    {
        for(int j=0;j<spobjects.size();j++)
        {
            if(objects.get(i).Name.equals(spobjects.get(j).Name))
                count1++;
        }
        if(count1==0)
        leftobjects.add(new ObjectNode(objects.get(i).Name, objects.get(i).Type,objects.get(i).Number,objects.get(i).pos));
        count1=0;
    }
        /*for(int i=0;i<spobjects.size()-1;i++)
        {
           for(int j=i+1;j<spobjects.size();j++)
           {
               if(spobjects.get(i).Name.equals(spobjects.get(j).Name))
                   spobjects.get(j).pos=spobjects.get(i).pos;
           }
        }*/
    /*for(int i=0;i<leftobjects.size();i++)
    	  System.out.println(leftobjects.get(i).Name+" "+leftobjects.get(i).Number+" "+leftobjects.get(i).Type+" "+leftobjects.get(i).pos); */   
        request.setAttribute("spatialobjs",spobjects);
        request.setAttribute("leftobjs",leftobjects); 
        getServletConfig().getServletContext().getRequestDispatcher("/view.jsp").forward(request,response);
        }
        
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
