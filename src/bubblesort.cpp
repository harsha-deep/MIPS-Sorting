#include <iostream>
#include <algorithm>
int main()
{
	int n;
	std::cout << "Enter the length of the list:" << std::endl;
	std::cin >> n;
	int arr[n];
	for (int i = 0; i < n; ++i)
		std::cin >> arr[i];
	for (int i = 0; i < n; i++)
	{
		for (int j = 0; j < n - i - 1; j++)
		{
			if (arr[j] > arr[j + 1])
				std::swap(arr[j], arr[j + 1]);
		}
	}
	for (int i = 0; i < n; ++i)
		std::cout << arr[i] << " ";
	return 0;
}
