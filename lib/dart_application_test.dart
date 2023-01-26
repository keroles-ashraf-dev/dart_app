import 'dart:math';

void main() {
  const int sum = 12;
  const int numsLen = 10;

  final random = Random();

  // generate list
  List<int> nums = List.generate(numsLen, (index) => random.nextInt(20) - 10);
  print('base-nums: $nums');

  // convert negative to positive
  nums = positiveList(nums, numsLen);
  print('positive-nums: $nums');

  // sort list
  nums = sortList(nums, numsLen);
  print('sorted-nums: $nums');

  // find lower 
  int lower = findLower(nums, numsLen, sum);
  int upper = lower + 1;

  // search for two indexes sum = 12
  final result = search(nums, numsLen, sum, lower, upper);

  if (result == null) {
    print('not found two indexes their sum = $sum');
  } else {
    print('result: ${result.num1}+${result.num2} = ${result.num1 + result.num2}');
  }
}

/// convert negative nums to positive
List<int> positiveList(List<int> nums, int numsLen) {
  for (var i = 0; i < numsLen; i++) {
    if (nums[i] < 0) nums[i] *= -1;
  }
  return nums;
}

/// sort list
List<int> sortList(List<int> nums, int numsLen) {
  int minIdx;

  for (var i = 0; i < numsLen - 1; i++) {
    minIdx = i;

    for (var j = i + 1; j < numsLen; j++) {
      if (nums[j] < nums[minIdx]) {
        minIdx = j;
      }
    }

    swap(nums, minIdx, i);
  }

  return nums;
}

void swap(List<int> nums, int minIdx, int i) {
  final temp = nums[minIdx];
  nums[minIdx] = nums[i];
  nums[i] = temp;
}

// find lower index that is less than (sum / 2)
int findLower(List<int> nums, int numsLen, int sum) {
  late final int lower;

  for (var i = numsLen - 1; i >= 0; i--) {
    if (nums[i] < (sum / 2)) {
      lower = i;
      break;
    }
  }

  return lower;
}

/// search for two indexes that their sum = passed sum
sumNums? search(List<int> nums, int numsLen, int sum, int lower, int upper) {
  sumNums? result;

  while (true) {
    final lowerVal = nums[lower];
    final upperVal = nums[upper];

    if ((lowerVal + upperVal) == sum) {
      result = sumNums(nums[lower], nums[upper]);
      break;
    }
    if ((lowerVal + upperVal) < sum) upper++;
    if ((lowerVal + upperVal) > sum) lower--;
    if ((lower) < 0) break;
    if ((upper) > numsLen - 1) break;
  }

  return result;
}

// data class
class sumNums {
  final int num1;
  final int num2;

  sumNums(this.num1, this.num2);
}
