
#include <iostream>
#include <fstream>
#include <string>
#include <vector>

using namespace std;



int main(){

	vector<string> big;
	vector<string> states;
	//vector<string> small;
	vector<string> new_precip;
	vector<string> new_jan;
	ifstream fin;
	//ifstream fin2;
	ifstream fin3;
	ifstream fin4;
	ifstream fin5;
	fin.open("BigList.txt");
	//fin2.open("MaxTempList.txt");
	fin3.open("states.txt");
	fin4.open("NewPrecip.txt");
	fin5.open("NewJanPrecip.txt");
	//ofstream fout;
	ofstream fout2;
	ofstream fout3;
	ofstream fout4;
	ofstream fout5;
	//fout.open("NewMaxTempList.txt");
	fout2.open("NewBigList.txt");
	fout3.open("NewStates.txt");
	fout4.open("NewPrecipFINAL.txt");
	fout5.open("NewJanPrecipFINAL.txt");
	string str;
	//string str2;
	string str3;
	string str4;
	string str5;
	bool flag = true;

	while(!fin.eof())
	{
		getline(fin,str);
		big.push_back(str);

	}
	/*
		while(!fin2.eof())
	{
		getline(fin2,str2);
		small.push_back(str2);
		
	}
	*/
			while(!fin3.eof())
	{
		getline(fin3,str3);
		states.push_back(str3);
		
	}
		while(!fin4.eof())
		{
			getline(fin4,str4);
			new_precip.push_back(str4);
		}

		while(!fin5.eof())
		{
			getline(fin5,str5);
			new_jan.push_back(str5);
		}


	//int i = 0;
	cout << big.size() << endl;
	//cout << new_precip.size() << endl;
	//cout << small.size() << endl;
	cout << states.size() << endl;
	
	while(big.size() != new_precip.size())
	{
		flag = true;
		while(flag){
			//while (i < big.size())
			for(int i=0; i<big.size(); i++)
			{
				if(big[i] != new_precip[i]){
					//big[i] = " ";
					//states[i] = " ";
					big.erase(big.begin() + i);
					states.erase(states.begin() + i);
					flag = false;
				}
			if(flag == false)
				break;
			}

		}
	}
	

	/*
	big is bigger than new_precip
	This goes through big size and checks to see whether an element in big is different from an element in newprecip
	If element(station ID) does not exist in newprecip, element is deleted from big
	This process continues until the lists are of equal size
	
	while(big.size() != new_precip.size())
	{
		flag = true;
		while(flag){
			for(int i=0; i<big.size(); i++)
			{
				if(big[i] != new_precip[i]){
					big.erase(big.begin() + i);
					states.erase(states.begin() + i);
					flag = false;
				}
			
			}

		}
	}
	*/
	
	for(int k=0; k<new_precip.size(); k++)
	{	
		fout2 << big[k] << endl;
		fout3 << states[k] << endl;
		fout4 << new_precip[k] << endl;
		fout5 << new_jan[k] << endl;
	}

	/*
		for(int k=0; k<new_precip.size(); k++)
	{
		fout4 << new_precip[k] << endl;
		fout5 << new_jan[k] << endl;
	}
	*/
	

	//cout << big[0];
	// cout << states[1];
	cout << big.size() << endl;
	cout << states.size() << endl;
//	cout << small.size() << endl;
	
	system("pause");
	

	return 0;

}
