# 🔢 1024!

- 프로젝트 기간: [2023년 10월 5일 ~ 10월 6일]
- 프로젝트 팀원: [Whales🐬](https://github.com/WhalesJin), [Moon🌕](https://github.com/hojun-jo), [Erick🦦](https://github.com/h-suo)

---

## 📖 목차
- 🍀 [소개](#소개) </br>
- 💻 [실행 화면](#실행_화면) </br>
- 🛠️ [사용 기술](#사용_기술) </br>
- 👀 [다이어그램](#Diagram) </br>
- 🧨 [트러블 슈팅](#트러블_슈팅) </br>

</br>

## 🍀 소개<a id="소개"></a>
같은 숫자 블럭을 매칭시켜 더 큰 숫자를 만들어보세요! 목표 점수 1024!
(단, 블럭 합성은 세로만 가능!)

</br>

## 💻 실행 화면<a id="실행_화면"></a>

| 게임 실행 | 게임 성공 | 게임 실패 |
| :--------: | :--------: | :--------: |
| <img src = "https://github.com/WhalesJin/2048/assets/124643545/db7e25e7-e305-409e-a250-e57272d33520"  width = "200"> | <img src = "https://github.com/WhalesJin/2048/assets/124643545/13b4a43b-e72b-49e5-a8dd-72b75311ef7b"  width = "200"> | <img src = "https://github.com/WhalesJin/2048/assets/124643545/7f8c2907-7c13-4cfc-88f7-a030ea6964b2"  width = "200"> |

</br>

## 🛠️ 사용 기술<a id="사용_기술"></a>
| 구현 내용	| 도구 |
|:---:|:---:|
|아키텍쳐|MVC|
|UI|UIKit|
|애니메이션|CoreAnimation|

</br>

## 👀 Diagram<a id="Diagram"></a>
### 📐 UML

<img src = "https://github.com/h-suo/h-suo/assets/109963294/307a9316-746f-489b-986d-4f6b38bcb9e4" width = "800">


</br>

## 🧨 트러블 슈팅<a id="트러블_슈팅"></a>


### 1️⃣ 블럭 연쇄 합성
🚨 **문제점** <br>
- 블럭이 단계적으로 쌓여있을 때, 연쇄적으로 합성이 되어야 하는데 제일 위에 있는 블럭만 합성되고 멈추는 문제점이 발생하였습니다.<br>
(예를 들어, 블럭이 아래부터 4, 2 순서로 쌓여있고 2를 추가하면 2+2=4, 4+4=8이 되어서 8블럭이 남아야 하는데 4블럭 두 개가 쌓여있는 상태에서 멈추는 현상)

💡 **해결방법** <br>
- `GameLogic`클래스의 `validatePosition`메서드에서 블럭이 합쳐지면 `pointArray`를 반환하면서 함수와 함께 자동으로 종료되었던 `for`문을 더 이상 합쳐질 블럭이 없을 때 `break`를 하고 그 외는 가장 아래쪽까지 반복할 수 있도록 코드를 수정하였습니다. 

🔀 **코드 변화** <br>
- <details>
    <summary> 수정 전 </summary>

    ```swift
    final class GameLogic {
    
        // ...
        func validatePosition(tappedX: CGFloat, block: BlockView) -> CGPoint {
        let (line, pointArray) = decideLine(tappedX: tappedX)

        for i in 0..<line.list.count-1 {
            if line.hasNext(i) {
                let nextBlockView = line.next(i)

                if compareBlockView(block, nextBlockView) {
                    block.updateState()
                    line.insert(block, at: i+1)
                    nextBlockView.removeFromSuperview()
                    return pointArray[i+1]
                }

                line.insert(block, at: i)
                return pointArray[i]
            } else if i == line.list.count-2 {
                line.insert(block, at: i+1)
                return pointArray[i+1]
            }
        }

        return validatePosition(tappedX: tappedX, block: block)
    }
    ```
    </details>
-  수정 후 
    ```swift
    final class GameLogic {
    
        // ...
        func validatePosition(tappedX: CGFloat, block: BlockView) -> CGPoint {
        let (line, pointArray) = decideLine(tappedX: tappedX)
        var value: CGPoint = CGPoint(x: 0, y: 0)

        for i in 0..<line.list.count-1 {
            if line.hasNext(i) {
                var nextBlockView = line.next(i)

                if compareBlockView(block, nextBlockView) == false {
                    line.insert(block, at: i)
                    value = pointArray[i]
                    break
                }

                block.updateState()
                line.insert(block, at: i+1)

                if i < 5 {
                    nextBlockView.removeFromSuperview()
                    nextBlockView = line.next(i+1)
                }

                value = pointArray[i+1]
            } else if i == line.list.count-2 {
                line.insert(block, at: i+1)
                value = pointArray[i+1]
                break
            }
        }

        return value
    }
    ```

<br>


### 2️⃣ Line
🚨 **문제점** <br>
- GameLogic 내 Line을 배열로만 관리하여 불필요한 코드가 많았습니다.

💡 **해결방법** <br>
- BlockView의 삽입 및 순서 관리를 해주는 Line 객체 생성하여 Line을 쉽게 관리했습니다.

🔀 **코드 변화** <br>
- <details>
    <summary> 수정 전 </summary>

    ```swift
    final class GameLogic {
        var line1: [Block?] = [nil, nil, nil, nil, nil, nil, nil]
        var line2: [Block?] = [nil, nil, nil, nil, nil, nil, nil]
        var line3: [Block?] = [nil, nil, nil, nil, nil, nil, nil]
        var line4: [Block?] = [nil, nil, nil, nil, nil, nil, nil]
        var line5: [Block?] = [nil, nil, nil, nil, nil, nil, nil]
        // ...
    }
    ```
    </details>
- 수정 후
    
    ```swift
    final class Line {
        var list: [Block?] = [nil, nil, nil, nil, nil, nil, nil]
   
        func insert(_ block: Block,at index: Int) {
            list.insert(block, at: index)
        }
   
        func hasNext(_ index: Int) -> Bool {
            return list[index + 1] != nil
        }
   
        func next(_ index: Int) -> Block {
            return list[index + 1]!
        }
    }
    ```
    
    ```swift
    final class GameLogic {
        var line1: Line = Line()
        var line2: Line = Line()
        var line3: Line = Line()
        var line4: Line = Line()
        var line5: Line = Line()
        // ...
    }
    ```

<br>

### 3️⃣ GameLogic
🚨 **문제점** <br>
- Controller에서 사용자 선택에 맞는 Block 좌표를 찾는 불필요한 로직을 수행했습니다.

💡 **해결방법** <br>
- GameLogic이 사용자 선택에 맞는 Line을 찾아 Block 좌표를 반환하도록 변경하여, Controller에서 GameLogic.validatePosition를 호출하여 Block의 좌표를 설정하도록 했습니다.

🔀 **코드 변화** <br>
- <details>
    <summary> 수정 전 </summary>

	```swift
	class ViewController: UIViewController {
	    
	    // ...
	    @objc
	    private func didTappedGridView() {
	        let tappedPointX = tapGestureRecognizer.location(in: view).x
	        
	        if tappedPointX >= 23, tappedPointX < 93 {
	            block.x = 23
	        } else if tappedPointX >= 93, tappedPointX < 163 {
	            block.x = 93
	        } else if tappedPointX >= 163, tappedPointX < 233 {
	            block.x = 163
	        } else if tappedPointX >= 233, tappedPointX < 303 {
	            block.x = 233
	        } else {
	            block.x = 303
	        }
	    }
	}    
	```
    </details>
- 수정 후

	```swift
	final class GameLogic {
	    
	    // ...
	    func decideLine(tappedX: CGFloat) -> (Line, [CGPoint]) {
	        if tappedX < 95 {
	            return (line1, pointArray1)
	        } else if tappedX >= 95, tappedX < 163 {
	            return (line2, pointArray2)
	        } else if tappedX >= 163, tappedX < 231 {
	            return (line3, pointArray3)
	        } else if tappedX >= 231, tappedX < 299 {
	            return (line4, pointArray4)
	        } else {
	            return (line5, pointArray5)
	        }
	    }
	    
	    func validatePosition(tappedX: CGFloat, block: BlockView) -> CGPoint {
	        let (line, pointArray) = decideLine(tappedX: tappedX)
	        var value: CGPoint = CGPoint(x: 0, y: 0)
	        
	        // point finding logic
	        
	        return value
	    }
	}
	```
    
	```swift
	class ViewController: UIViewController {
	    
	    // ...
	    @objc
	    private func didTappedGridView() {
	        let tappedPointX = tapGestureRecognizer.location(in: view).x
	        let point = gameLogic.validatePosition(tappedX: tappedPointX, block: blockView.blockState)
	        
	        blockView.frame.origin = point
	    }
	}
	```

<br>

### 4️⃣ 애니메이션
🚨 **문제점** <br>
- 기본적으로 블럭이 생성될 때 위치에 바로 나타나기 때문에 블럭이 여러 개 쌓여있을 경우 블럭이 생성되었는지 인식하기 힘들다는 문제가 있습니다. 이러한 사용자 경험상 문제를 해결하기 위해 블럭 생성 시 눈에 띄게 만들 방법이 필요했습니다.

💡 **해결방법** <br>
- 블럭 생성 시 애니메이션을 추가해 눈에 띄고 보기 좋게 만들어 사용자 경험을 개선했습니다.

🔀 **코드 변화** <br>
- 애니메이션 추가

    ```swift
    func runSpringAnimation() {
        let jump = CASpringAnimation(keyPath: "transform.scale")
        jump.damping = 15
        jump.mass = 1
        jump.initialVelocity = 10
        jump.stiffness = 100
        jump.fromValue = 0
        jump.toValue = 1
        jump.duration = jump.settlingDuration
        
        self.layer.add(jump, forKey: nil)
    }
    ```

<br>
